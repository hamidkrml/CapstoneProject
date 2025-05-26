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
    @Query private var kullanicilar: [KullanciBilgileri]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    HStack(spacing: 40) {
                        ProfileView()
                            .maxLeft
                        Button {
                            LoginFirbase.shared.signout()
                        } label: {
                            Text("Cıkış Yap")
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
                            Text("Ceki\n\(kullanici.ceki)")
                                .padding()
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
                        
                        HStack(spacing: 30){
                            Text("Yaş\n\(kullanici.yas)")
                                .padding()
                            Text("Cinsiyet\n\(kullanici.cinsiyet)")
                                .padding()
                            Text("Email\n\(kullanici.email)")
                                .padding()
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
        }
    }
}

#Preview {
    ProfilSayfasi()
        .modelContainer(for: KullanciBilgileri.self)
}
