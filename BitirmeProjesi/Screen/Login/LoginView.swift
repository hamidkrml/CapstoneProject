//
//  kayitEkrani.swift
//  BitirmeProjesi
//
//  Created by hamid on 29.11.24.
//

import SwiftUI

struct kayitEkrani: View {
    @StateObject var viewModel = LoginViewModel()
    @FocusState private var focusedField: Field?
    
    enum Field {
        case email, password
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ExtractedView.shared
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 50) {
                        Image("fitness")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
                        
                        VStack(spacing: 25) {
                            TextField("E-posta", text: $viewModel.email)
                                .textContentType(.emailAddress)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .focused($focusedField, equals: .email)
                                .submitLabel(.next)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                            
                            SecureField("Şifre", text: $viewModel.password)
                                .textContentType(.password)
                                .focused($focusedField, equals: .password)
                                .submitLabel(.done)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                        .padding(.horizontal, 20)
                        
                        Button {
                            focusedField = nil
                            viewModel.attemptLogin()
                        } label: {
                            if viewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.yellow.opacity(0.8))
                                    .cornerRadius(25)
                            } else {
                                Text("Giriş Yap")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.yellow, Color.yellow.opacity(0.8)]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(25)
                                    .shadow(color: .yellow.opacity(0.3), radius: 5, x: 0, y: 3)
                            }
                        }
                        .disabled(viewModel.isLoading)
                        .padding(.horizontal, 20)
                        
                        NavigationLink(destination: KayitOl()) {
                            HStack {
                                Text("Henüz hesabınız yok mu?")
                                    .foregroundColor(.gray)
                                Text("Kayıt Ol")
                                    .foregroundColor(.yellow.opacity(0.6))
                                    .fontWeight(.semibold)
                            }
                            .padding(.vertical, 10)
                        }
                    }
                    .padding(.vertical, 50)
                }
                .padding(.bottom, 30) // Klavye için ekstra boşluk
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Hoş Geldiniz")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            .onSubmit {
                switch focusedField {
                case .email:
                    focusedField = .password
                case .password:
                    focusedField = nil
                    viewModel.attemptLogin()
                case .none:
                    break
                }
            }
            .onTapGesture {
                focusedField = nil
            }
        }
        .navigationBarBackButtonHidden()
        .alert("Hata", isPresented: $viewModel.showAlert) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}

#Preview {
    kayitEkrani()
}



