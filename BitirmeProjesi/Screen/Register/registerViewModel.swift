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
                modelContext.insert(kullaniciBilgileri)
                try modelContext.save()
                
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    
}
