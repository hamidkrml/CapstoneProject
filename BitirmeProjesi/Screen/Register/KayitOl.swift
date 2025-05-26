//
    //  KayitOl.swift
//  BitirmeProjesi
//
//  Created by hamid on 01.12.24.
//

import SwiftUI
import SwiftData

struct KayitOl: View {
    @EnvironmentObject var viewModel: registerViewModel
    @Environment(\.modelContext) private var modelContext
    @FocusState private var focusedField: Field?
    
    enum Field {
        case ad, soyad, gmail, sifre, boy, ceki, yas
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ExtractedView.shared
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 35) {
                        HStack {
                            Image("fitness")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .padding()
                            Text("Kayit Ol")
                                .font(.largeTitle)
                                .italic()
                                .foregroundStyle(.white)
                                .lineSpacing(15)
                                .shadow(color: .gray, radius: 2, x: 2, y: 2)
                        }
                        .maxLeft
                        .top8
                        
                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(.red)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(10)
                        }
                        
                        HStack(spacing: 20) {
                            TextField("Ad", text: $viewModel.ad)
                                .textContentType(.givenName)
                                .focused($focusedField, equals: .ad)
                                .submitLabel(.next)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                            
                            TextField("SoyAd", text: $viewModel.soyad)
                                .textContentType(.familyName)
                                .focused($focusedField, equals: .soyad)
                                .submitLabel(.next)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                        
                        VStack(spacing: 30) {
                            TextField("E-posta", text: $viewModel.gmail)
                                .textContentType(.emailAddress)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .focused($focusedField, equals: .gmail)
                                .submitLabel(.next)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                            
                            SecureField("Şifre", text: $viewModel.Sifre)
                                .textContentType(.newPassword)
                                .focused($focusedField, equals: .sifre)
                                .submitLabel(.next)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                        
                        HStack(spacing: 20) {
                            TextField("Boy (cm)", text: $viewModel.boy)
                                .keyboardType(.decimalPad)
                                .focused($focusedField, equals: .boy)
                                .submitLabel(.next)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                            
                            TextField("Kilo (kg)", text: $viewModel.ceki)
                                .keyboardType(.decimalPad)
                                .focused($focusedField, equals: .ceki)
                                .submitLabel(.next)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                        
                        HStack(spacing: 20) {
                            TextField("Yaş", text: $viewModel.yas)
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: .yas)
                                .submitLabel(.done)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                            
                            Picker("Cinsiyet", selection: $viewModel.cinsiyet) {
                                ForEach(viewModel.cinsiyetSecenekleri, id: \.self) { secenek in
                                    Text(secenek).tag(secenek)
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(20)
                        }
                        
                        Button {
                            Task {
                                // SwiftData'ya kaydet
                                let kullaniciBilgileri = KullanciBilgileri(
                                    ad: viewModel.ad,
                                    soyad: viewModel.soyad,
                                    boy: viewModel.boy,
                                    ceki: viewModel.ceki,
                                    yas: viewModel.yas,
                                    cinsiyet: viewModel.cinsiyet,
                                    email: viewModel.gmail
                                )
                                modelContext.insert(kullaniciBilgileri)
                                try? modelContext.save()
                                
                                // Firebase'e kaydet
                                viewModel.CreateUser()
                            }
                        } label: {
                            if viewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.yellow.opacity(0.8))
                                    .cornerRadius(25)
                            } else {
                                Text("Kayıt Ol")
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
                    }
                    .padding(.horizontal, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            
            .onSubmit {
                switch focusedField {
                case .ad:
                    focusedField = .soyad
                case .soyad:
                    focusedField = .gmail
                case .gmail:
                    focusedField = .sifre
                case .sifre:
                    focusedField = .boy
                case .boy:
                    focusedField = .ceki
                case .ceki:
                    focusedField = .yas
                case .yas:
                    focusedField = nil
                case .none:
                    break
                }
            }
            .onTapGesture {
                focusedField = nil
            }
        }
        .preferredColorScheme(.dark)
        .alert("Hata", isPresented: .constant(!viewModel.errorMessage.isEmpty)) {
            Button("Tamam", role: .cancel) {
                viewModel.errorMessage = ""
            }
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}
