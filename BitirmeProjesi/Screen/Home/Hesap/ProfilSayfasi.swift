//
//  ProfilSayfasi.swift
//  BitirmeProjesi
//
//  Created by hamid on 11.03.25.
//

import SwiftUI
import SwiftData

struct ProfilSayfasi: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \KullanciBilgileri.email) private var kullanicilar: [KullanciBilgileri]
    @State private var showingLogoutAlert = false
    @State private var ViewModel = ProfileViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    HStack(spacing: 40) {
                        ProfileView()
                            .maxLeft
                        Button {
                            showingLogoutAlert = true
                        } label: {
                            Text("Çıkış Yap")
                                .foregroundColor(.white)
                                .font(.customfont(font: .Bold, fontSize: 12))
                        }
                        .padding(.trailing,9)
                    }
                    
                    if let kullanici = kullanicilar.first {
                        let bilgiler: [(String, String)] = [
                            ("Ad", kullanici.ad),
                            ("Soyad", kullanici.soyad),
                            ("Boy", kullanici.boy),
                            ("Kilo", kullanici.ceki),
                            ("Yaş", kullanici.yas),
                            ("Cinsiyet", kullanici.cinsiyet)
                        ]
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(bilgiler, id: \.0) { title, value in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(title)
                                        .font(.customfont(font: .medium, fontSize: 12))
                                        .foregroundColor(.gray)
                                    Text(value)
                                        .font(.customfont(font: .Bold, fontSize: 16))
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(12)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(22)
                        .shadow(color: .gray, radius: 2, x: 2, y: 2)
                    } else {
                        Text("Kullanıcı bilgileri bulunamadı")
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Divider()
                    
                    if let kullanici = kullanicilar.first {
                        let bmiText = kullanici.bmi ?? "Hesaplanmamış"
                        let calorieText = kullanici.dailyCalorieNeed ?? "Hesaplanmamış"
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Beden Kitle İndeksi")
                                .font(.customfont(font: .medium, fontSize: 12))
                                .foregroundColor(.gray)
                            Text(bmiText)
                                .font(.customfont(font: .Bold, fontSize: 16))
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Günlük Kalori İhtiyacı")
                                .font(.customfont(font: .medium, fontSize: 12))
                                .foregroundColor(.gray)
                            Text(calorieText)
                                .font(.customfont(font: .Bold, fontSize: 16))
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    Spacer()
                }
            }.navigationTitle("Profil sayfasi")
                .background(
                    ExtractedView.shared
                )
                .preferredColorScheme(.dark)
                .alert("Çıkış Yap", isPresented: $showingLogoutAlert) {
                    Button("İptal", role: .cancel) { }
                    Button("Çıkış Yap", role: .destructive) {
                        // SwiftData'dan kullanıcı bilgilerini sil
                        if let kullanici = kullanicilar.first {
                            modelContext.delete(kullanici)
                            try? modelContext.save()
                        }
                        // Firebase'den çıkış yap
                        LoginFirbase.shared.signout()
                    }
                } message: {
                    Text("Çıkış yapmak istediğinizden emin misiniz?")
                }
        }
    }
}

#Preview {
    ProfilSayfasi()
        .modelContainer(for: KullanciBilgileri.self)
}
