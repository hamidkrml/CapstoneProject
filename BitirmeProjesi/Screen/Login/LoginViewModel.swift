//
//  LoginViewModel.swift
//  BitirmeProjesi
//
//  Created by hamid on 09.03.25.
//

import Foundation
import FirebaseAuth
import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String? = nil
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var isLoading = false
    
    var isValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func attemptLogin() {
        guard isValid else {
            alertMessage = "Lütfen tüm alanları doldurun"
            showAlert = true
            return
        }
        
        guard validateEmail() else {
            alertMessage = "Geçerli bir email adresi giriniz"
            showAlert = true
            return
        }
        
        Task {
            await signIn()
        }
    }
    
    func signIn() async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await LoginFirbase.shared.login(email: email, password: password)
        } catch {
            self.alertMessage = hataYiMesajaÇevir(error)
            self.showAlert = true
        }
        
        isLoading = false
    }
    
    func hataYiMesajaÇevir(_ error: Error) -> String {
        let err = error as NSError
        print("Hata kodu: \(err.code), Açıklama: \(err.localizedDescription)")
        
        switch err.code {
        case AuthErrorCode.wrongPassword.rawValue:
            return "Girdiğiniz şifre yanlış."
        case AuthErrorCode.invalidEmail.rawValue:
            return "Geçersiz e-posta adresi."
        case AuthErrorCode.userNotFound.rawValue:
            return "Bu e-posta adresiyle kayıtlı bir hesap bulunamadı."
        case AuthErrorCode.tooManyRequests.rawValue:
            return "Çok fazla başarısız giriş denemesi. Lütfen daha sonra tekrar deneyin."
        case AuthErrorCode.networkError.rawValue:
            return "İnternet bağlantınızı kontrol edin."
        default:
            return "Kullanıcı adınız veya şifreniz yanlıştır"
        }
    }
}

