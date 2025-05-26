//
//  KullanciBilgileri.swift
//  BitirmeProjesi
//
//  Created by hamid karimli on 26.05.2025.
//

import SwiftData

@Model
final class KullanciBilgileri {
    var ad: String
    var soyad: String
    var boy: String
    var ceki: String
    var yas: String
    var cinsiyet: String
    var email: String
    
    init(ad: String, soyad: String, boy: String, ceki: String, yas: String, cinsiyet: String, email: String) {
        self.ad = ad
        self.soyad = soyad
        self.boy = boy
        self.ceki = ceki
        self.yas = yas
        self.cinsiyet = cinsiyet
        self.email = email
    }
    
    
    
}


