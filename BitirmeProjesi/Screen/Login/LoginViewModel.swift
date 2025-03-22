//
//  LoginViewModel.swift
//  BitirmeProjesi
//
//  Created by hamid on 09.03.25.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String? = nil
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    
    func attemptLogin() {
        Task {try await signIn()}
    }
    func signIn() async throws{
        
        do{try await LoginFirbase.shared.login(email: email, password: password)}
        
        catch{
            await MainActor.run {
                self.alertMessage = hataYiMesajaÇevir(error)
                self.showAlert = true}
            throw error
        }     
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
        default:
            return "Kullanci adiniz ve ya sifreniz yanlistir"
        }
    }
}

