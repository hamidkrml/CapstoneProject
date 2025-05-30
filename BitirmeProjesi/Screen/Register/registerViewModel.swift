//
//  registerViewModel.swift
//  BitirmeProjesi
//
//  Created by hamid on 09.03.25.
//

import Foundation
import SwiftUI
import SwiftData
import FirebaseAuth

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
        // Ondalık ayırıcı kontrolü (Türkçe için)
        let sanitizedBoy = boy.replacingOccurrences(of: ",", with: ".")
        guard let height = Double(sanitizedBoy) else { return false }
        return height > 0 && height < 300
    }
    
    func validateWeight() -> Bool {
        // Ondalık ayırıcı kontrolü (Türkçe için)
        let sanitizedCeki = ceki.replacingOccurrences(of: ",", with: ".")
        guard let weight = Double(sanitizedCeki) else { return false }
        return weight > 0 && weight < 500
    }
    
    func validateAge() -> Bool {
        guard let age = Int(yas) else { return false }
        return age > 0 && age < 120
    }
    
    func calculateBMI(weight: String, height: String) -> String {
        // Ondalık ayırıcı düzeltme
        let sanitizedWeight = weight.replacingOccurrences(of: ",", with: ".")
        let sanitizedHeight = height.replacingOccurrences(of: ",", with: ".")
        
        guard let w = Double(sanitizedWeight),
              let h = Double(sanitizedHeight) else { return "N/A" }
        
        let heightInMeters = h / 100
        let bmi = w / (heightInMeters * heightInMeters)
        return String(format: "%.1f", bmi)
    }

    func calculateDailyCalorieNeed(weight: String, height: String, age: String, gender: String) -> String {
        // Ondalık ayırıcı düzeltme
        let sanitizedWeight = weight.replacingOccurrences(of: ",", with: ".")
        let sanitizedHeight = height.replacingOccurrences(of: ",", with: ".")
        
        guard let w = Double(sanitizedWeight),
              let h = Double(sanitizedHeight),
              let a = Int(age) else { return "N/A" }
        
        let bmr: Double
        if gender == "Erkek" {
            bmr = 10 * w + 6.25 * h - 5 * Double(a) + 5
        } else {
            bmr = 10 * w + 6.25 * h - 5 * Double(a) - 161
        }
        
        // Aktivite faktörü ekle (örneğin 1.2 = hareketsiz)
        let dailyCalorie = bmr * 1.2
        return String(format: "%.0f", dailyCalorie)
    }
    
    func CreateUser() {
        // 1. Validasyon kontrolleri
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
            errorMessage = "Geçerli bir boy değeri giriniz (0-300 cm)"
            return
        }
        
        guard validateWeight() else {
            errorMessage = "Geçerli bir kilo değeri giriniz (0-500 kg)"
            return
        }
        
        guard validateAge() else {
            errorMessage = "Geçerli bir yaş değeri giriniz (1-119)"
            return
        }
        
        isLoading = true
        errorMessage = ""
        
        Task {
            do {
                // 2. Firebase kaydı
                try await LoginFirbase.shared.createUser(
                    email: gmail,
                    password: Sifre,
                    Kboyu: boy,
                    Kceki: ceki,
                    Kad: ad,
                    Ksoyad: soyad
                )
                
                // 3. BMI ve kalori hesaplama
                let bmiValue = calculateBMI(weight: ceki, height: boy)
                let dailyCalorie = calculateDailyCalorieNeed(
                    weight: ceki,
                    height: boy,
                    age: yas,
                    gender: cinsiyet
                )
                
                // 4. SwiftData işlemleri (Main thread'de)
                await MainActor.run {
                    do {
                        // Önceki kullanıcıları temizle
                        let descriptor = FetchDescriptor<KullanciBilgileri>()
                        let existingUsers = try modelContext.fetch(descriptor)
                        
                        for user in existingUsers {
                            modelContext.delete(user)
                        }
                        
                        // Yeni kullanıcı oluştur
                        let newUser = KullanciBilgileri(
                            ad: self.ad,
                            soyad: self.soyad,
                            boy: self.boy,
                            ceki: self.ceki,
                            yas: self.yas,
                            cinsiyet: self.cinsiyet,
                            email: self.gmail
                        )
                        
                        newUser.bmi = bmiValue
                        newUser.dailyCalorieNeed = dailyCalorie
                        
                        modelContext.insert(newUser)
                        
                        // Veriyi kalıcı olarak kaydet
                        try modelContext.save()
                        
                        // 5. Kullanıcı oturum bilgilerini kaydet
                        UserDefaults.standard.set(self.gmail, forKey: "userEmail")
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        
                        print("✅ Kullanıcı başarıyla kaydedildi")
                        print("BMI: \(bmiValue)")
                        print("Günlük Kalori: \(dailyCalorie)")
                        
                    } catch {
                        print("❌ SwiftData kayıt hatası: \(error)")
                        self.errorMessage = "Veritabanı hatası: \(error.localizedDescription)"
                    }
                }
                
            } catch let firebaseError {
                await MainActor.run {
                    print("❌ Firebase kayıt hatası: \(firebaseError)")
                    self.errorMessage = "Kayıt hatası: \(firebaseError.localizedDescription)"
                }
            }
            
            await MainActor.run {
                self.isLoading = false
            }
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
            print("✅ Kullanıcı bilgileri güncellendi")
        } catch {
            print("❌ Güncelleme hatası: \(error)")
        }
    }
}
