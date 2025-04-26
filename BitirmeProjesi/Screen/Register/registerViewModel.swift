//
//  registerViewModel.swift
//  BitirmeProjesi
//
//  Created by hamid on 09.03.25.
//

import Foundation

class registerViewModel :ObservableObject{
    
    @Published var ad   :String = ""
    @Published var soyad:String = ""
    @Published var Sifre:String = ""
    @Published var gmail:String = ""
    @Published var boy  :String = ""
    @Published var ceki :String = ""
  
    func CreateUser()async throws{
        try await LoginFirbase.shared.createUser(email: gmail, password: Sifre,Kboyu: boy,Kceki: ceki,Kad: ad,Ksoyad: soyad)
    }
    
}
