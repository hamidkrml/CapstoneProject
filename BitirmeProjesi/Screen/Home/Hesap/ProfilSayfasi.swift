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
                        
                            HStack(spacing: 30){
                                Text("Ad\n\(kullanici.ad)")
                                    .padding()
                                Text("SoyAd\n\(kullanici.soyad)")
                                    .padding()
                                Text("Boy\n\(kullanici.boy)")
                                    .padding()
                                Text("Kilo\n\(kullanici.ceki)")
                                    .padding()
                                Text("Yaş\n\(kullanici.yas)")
                                    .padding()
                                Text("Cinsiyet\n\(kullanici.cinsiyet)")
                            }
                            .maxLeft
                            .padding()
                            .font(.customfont(font: .light, fontSize: 14))
                            .italic()
                            .foregroundStyle(.white)
                            .lineSpacing(15)
                            .shadow(color:.gray,radius: 2,x: 2,y:2)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(22, corner: .allCorners)
                            
                          
//                            .maxLeft
//                            .padding()
//                            .font(.customfont(font: .light, fontSize: 14))
//                            .italic()
//                            .foregroundStyle(.white)
//                            .lineSpacing(15)
//                            .shadow(color:.gray,radius: 2,x: 2,y:2)
//                            .background(Color.gray.opacity(0.2))
//                            .cornerRadius(22, corner: .allCorners)
                        
                    } else {
                        Text("Kullanıcı bilgileri bulunamadı")
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Divider()
                    
                    VStack{
                        Text("Grafikler Eklenecek")
                    }
                    Spacer()
                }
            }
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
