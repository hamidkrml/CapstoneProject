//
//  kayitEkrani.swift
//  BitirmeProjesi
//
//  Created by hamid on 29.11.24.
//

import SwiftUI


struct kayitEkrani: View {
    
    
    @StateObject var viewModel = LoginViewModel()
    
    
    enum fieldKeybord{
        case KullaniciAdi
        case Sifre
    }
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(spacing: 50){
 
                    Image("fitness")
                            .resizable()
                            .frame(width: 100,height: 100)
                            .clipShape(Circle())
 
                    Spacer()
                    VStack(spacing: 60){
                        
                        
                        TextField("Kullanci Adin",text: $viewModel.email)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(20, corner: .allCorners)
                        
                        
                        SecureField("Şifrenizi Giriniz", text: $viewModel.password)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(20, corner: .allCorners)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal,20)
                    
                    .padding()
                    
                    
                    
                    Button{
                        viewModel.attemptLogin()
                    } label: {
                        Buttongenel(adyaz: "Giris Yap")
                    }
                    
                    
                    NavigationLink(destination: KayitOl()){
                        Text("Henuz hesapiniz yok mu?")
                            .font(.title2)
                            .underline(true,color: .yellow.opacity(0.5))
                            .lineLimit(1)
                            .foregroundColor(.gray.opacity(0.7))
                        
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .padding(.bottom, 100)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Hoş Geldiniz")
                        .font(.title2)
                }
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
                ExtractedView.shared
            )
            .preferredColorScheme(.dark)
            
            
            
            
            .scrollDismissesKeyboard(.automatic)
        }
        .alert("Hata", isPresented: $viewModel.showAlert) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
        }
        
        
    }
    
}

#Preview {
    NavigationView{
        kayitEkrani()
        
    }
    
}



