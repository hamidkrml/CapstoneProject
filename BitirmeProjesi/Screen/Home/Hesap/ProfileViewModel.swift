//
//  ProfileViewModel.swift
//  BitirmeProjesi
//
//  Created by hamid on 11.03.25.
//
import SwiftUI
import PhotosUI

class ProfileViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? = nil
    @Published var profileImage: Image? = nil

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func loadImage(from item: PhotosPickerItem?) {
        guard let item = item else { return }

        item.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let data = data, let uiImage = UIImage(data: data) {
                        self.profileImage = Image(uiImage: uiImage)
                    } else {
                        print("Resim verisi alınamadı")
                    }
                case .failure(let error):
                    print("Hata oluştu: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func calculateBMI(weight: String, height: String) -> String {
        guard let kilo = Double(weight), let boyCm = Double(height) else {
            return "Geçersiz veri"
        }
        let boyMetre = boyCm / 100.0
        guard boyMetre > 0 else { return "Geçersiz boy" }

        let bmi = kilo / (boyMetre * boyMetre)
        return String(format: "BMI: %.1f", bmi)
    }

    func calculateDailyCalorieNeed(weight: String, height: String, age: String, gender: String) -> String {
        guard let kilo = Double(weight),
              let boy = Double(height),
              let yas = Double(age) else {
            return "Geçersiz veri"
        }

        var bmr: Double

        if gender.lowercased() == "erkek" {
            bmr = 10 * kilo + 6.25 * boy - 5 * yas + 5
        } else if gender.lowercased() == "kadın" || gender.lowercased() == "kadin" {
            bmr = 10 * kilo + 6.25 * boy - 5 * yas - 161
        } else {
            return "Geçersiz cinsiyet"
        }

        return String(format: "Kcal: %.0f ", bmr)
    }
}
