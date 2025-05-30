//
//  registerViewModel.swift
//  BitirmeProjesi
//
//  Created by hamid on 09.03.25.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
class registerViewModel: ObservableObject {
    @Published var ad: String = ""
    @Published var soyad: String = ""
    @Published var Sifre: String = ""
    @Published var gmail: String = ""
    @Published var boy: String = ""
    @Published var ceki: String = ""
    @Published var yas: String = ""
    @Published var cinsiyet: String = "Erkek"
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    let cinsiyetSecenekleri = ["Erkek", "Kadın"]
    let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    var isValid: Bool {
        !ad.isEmpty && !soyad.isEmpty && !Sifre.isEmpty && !gmail.isEmpty &&
        !boy.isEmpty && !ceki.isEmpty && !yas.isEmpty && !cinsiyet.isEmpty
    }
    
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: gmail)
    }
    
    func validatePassword() -> Bool {
        return Sifre.count >= 6
    }
    
    func validateHeight() -> Bool {
        guard let height = Double(boy) else { return false }
        return height > 0 && height < 300
    }
    
    func validateWeight() -> Bool {
        guard let weight = Double(ceki) else { return false }
        return weight > 0 && weight < 500
    }
    
    func validateAge() -> Bool {
        guard let age = Int(yas) else { return false }
        return age > 0 && age < 120
    }
    
    func calculateBMI(weight: String, height: String) -> String {
        guard let w = Double(weight), let h = Double(height) else { return "N/A" }
        let heightInMeters = h / 100
        let bmi = w / (heightInMeters * heightInMeters)
        return String(format: "%.1f", bmi)
    }

    func calculateDailyCalorieNeed(weight: String, height: String, age: String, gender: String) -> String {
        guard let w = Double(weight), let h = Double(height), let a = Double(age) else { return "N/A" }
        let bmr: Double
        if gender == "Erkek" {
            bmr = 10 * w + 6.25 * h - 5 * a + 5
        } else {
            bmr = 10 * w + 6.25 * h - 5 * a - 161
        }
        return String(format: "%.0f", bmr)
    }
    
    func CreateUser() {
        guard isValid else {
            errorMessage = "Lütfen tüm alanları doldurun"
            return
        }
        
        guard validateEmail() else {
            errorMessage = "Geçerli bir email adresi giriniz"
            return
        }
        
        guard validatePassword() else {
            errorMessage = "Şifre en az 6 karakter olmalıdır"
            return
        }
        
        guard validateHeight() else {
            errorMessage = "Geçerli bir boy değeri giriniz"
            return
        }
        
        guard validateWeight() else {
            errorMessage = "Geçerli bir kilo değeri giriniz"
            return
        }
        
        guard validateAge() else {
            errorMessage = "Geçerli bir yaş değeri giriniz"
            return
        }
        
        isLoading = true
        errorMessage = ""
        
        Task { @MainActor in
            do {
                // Firebase'e kayıt
                try await LoginFirbase.shared.createUser(
                    email: gmail,
                    password: Sifre,
                    Kboyu: boy,
                    Kceki: ceki,
                    Kad: ad,
                    Ksoyad: soyad
                )
                
                // BMI ve günlük kalori ihtiyacını hesapla
                let bmiValue = calculateBMI(weight: ceki, height: boy)
                let dailyCalorie = calculateDailyCalorieNeed(weight: ceki, height: boy, age: yas, gender: cinsiyet)
                
                // SwiftData'ya kayıt
                let kullaniciBilgileri = KullanciBilgileri(
                    ad: ad,
                    soyad: soyad,
                    boy: boy,
                    ceki: ceki,
                    yas: yas,
                    cinsiyet: cinsiyet,
                    email: gmail
                )
                
                // Hesaplanan değerleri kaydet
                kullaniciBilgileri.bmi = bmiValue
                kullaniciBilgileri.dailyCalorieNeed = dailyCalorie
                
                // Önceki kullanıcı bilgilerini temizle
                let descriptor = FetchDescriptor<KullanciBilgileri>()
                if let existingUsers = try? modelContext.fetch(descriptor) {
                    for user in existingUsers {
                        modelContext.delete(user)
                    }
                }
                
                // Yeni kullanıcı bilgilerini kaydet
                modelContext.insert(kullaniciBilgileri)
                try modelContext.save()
                
                // Kullanıcı bilgilerini UserDefaults'a da kaydet
                UserDefaults.standard.set(gmail, forKey: "userEmail")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                
                print("Kullanıcı bilgileri başarıyla kaydedildi:")
                print("BMI: \(bmiValue)")
                print("Günlük Kalori İhtiyacı: \(dailyCalorie)")
                
            } catch {
                errorMessage = error.localizedDescription
                print("Kayıt hatası: \(error.localizedDescription)")
            }
            isLoading = false
        }
    }
    
    // Kullanıcı bilgilerini getir
    func fetchUserData() -> KullanciBilgileri? {
        let descriptor = FetchDescriptor<KullanciBilgileri>()
        do {
            let users = try modelContext.fetch(descriptor)
            return users.first
        } catch {
            print("Kullanıcı bilgileri getirilirken hata: \(error)")
            return nil
        }
    }
    
    // Kullanıcı bilgilerini güncelle
    func updateUserData() {
        guard let user = fetchUserData() else { return }
        
        // BMI ve kalori ihtiyacını güncelle
        user.bmi = calculateBMI(weight: user.ceki, height: user.boy)
        user.dailyCalorieNeed = calculateDailyCalorieNeed(
            weight: user.ceki,
            height: user.boy,
            age: user.yas,
            gender: user.cinsiyet
        )
        
        do {
            try modelContext.save()
        } catch {
            print("Kullanıcı bilgileri güncellenirken hata: \(error)")
        }
    }
}
