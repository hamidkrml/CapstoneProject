//
//  DiyetView.swift
//  BitirmeProjesi
//
//  Created by hamid karimli on 28.05.2025.
//
import SwiftUI
import SwiftData

struct DiyetView2: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var calorieTracker: CalorieTracker
    @State private var showAssistant = false
    @State private var dietPlan: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                ExtractedView.shared
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 10) {
                        Spacer()
                        Divider()
                        
                        ProductSider()
                            .environmentObject(calorieTracker)
                        
                        Spacer()
                        
                        mealNavigationSection(title: "Kahvaltı", image: "icon")
                        Divider()
                        
                        mealNavigationSection(title: "Öğle", image: "icon")
                        Divider()
                        
                        mealNavigationSection(title: "Akşam", image: "icon")
                        Divider()
                        
                        mealNavigationSection(title: "Ara Öğün", image: "icon")
                        Divider()
                    }
                    .padding(.horizontal)
                }
                
                // Yapay Zeka Asistanı Butonu
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showAssistant = true
                                loadDietPlan()
                            }
                        }) {
                            Image(systemName: "sparkles")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding()
                        .accessibilityLabel("Yapay Zeka Asistanı")
                    }
                }
                .zIndex(1)
            }
            .navigationTitle("Bugün")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    calendarButton
                }
            }
            .sheet(isPresented: $showAssistant) {
                dietPlanSheet
            }
        }
    }
    
    private var dietPlanSheet: some View {
        NavigationView {
            ZStack {
                ExtractedView.shared
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        if isLoading {
                            ProgressView()
                                .scaleEffect(1.5)
                                .padding()
                        } else if !errorMessage.isEmpty {
                            VStack(spacing: 16) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.red)
                                
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center)
                                
                                Button("Tekrar Dene") {
                                    loadDietPlan()
                                }
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                            }
                            .padding()
                        } else if !dietPlan.isEmpty {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Kişisel Diyet Planınız")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("ButtonC"))
                                
                                Text(dietPlan)
                                    .foregroundColor(Color("ButtonC"))
                                    .lineSpacing(4)
                                
                                Button(action: {
                                    loadDietPlan()
                                }) {
                                    HStack {
                                        Image(systemName: "arrow.clockwise")
                                        Text("Yeni Plan Oluştur")
                                    }
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.2))
                            )
                            .modifier(CardModifier())
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Yapay Zeka Asistanı")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Kapat") {
                        showAssistant = false
                    }
                }
            }
        }
    }
    
    private func loadDietPlan() {
        isLoading = true
        errorMessage = ""
        
        Task {
            do {
                dietPlan = try await NetworkMeneger.shared.generateDietPlanFromUserData(modelContext: modelContext)
            } catch {
                errorMessage = "Diyet planı oluşturulurken bir hata oluştu: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
    
    private var calendarButton: some View {
        Button(action: {
            print("Takvim butonuna tıklandı")
        }) {
            Image(systemName: "calendar.and.person")
        }
    }
    
    private func mealNavigationSection(title: String, image: String) -> some View {
        NavigationLink {
            SearchView(viewModel: SearchViewModel(modelContext: modelContext))
        } label: {
            DiyetCard(image: image, title: title)
        }
    }
}
