//
    //  KayitOl.swift
//  BitirmeProjesi
//
//  Created by hamid on 01.12.24.
//

import SwiftUI

struct KayitOl: View {
    @EnvironmentObject var viewModel: registerViewModel
    @State private var keyboardHeight: CGFloat = 0
    @FocusState private var focusedField: Field?
    
    enum Field {
        case ad, soyad, gmail, sifre, boy, ceki
    }
    
    var body: some View {
        NavigationView {
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
                        TextField("Gmail", text: $viewModel.gmail)
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
                            .submitLabel(.done)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    
                    Button {
                        Task {
                            try await viewModel.CreateUser()
                        }
                    } label: {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Buttongenel(adyaz: "Kayit Ol")
                        }
                    }
                    .disabled(viewModel.isLoading)
                }
                .padding(.horizontal, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ExtractedView.shared)
            .preferredColorScheme(.dark)
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
                    focusedField = nil
                case .none:
                    break
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Tamam") {
                        focusedField = nil
                    }
                }
            }
        }
        .navHideWithout
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    NavigationStack {
        KayitOl()
            .environmentObject(registerViewModel())
    }
}
