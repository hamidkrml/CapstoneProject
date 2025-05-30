//
//  DiyetView.swift
//  BitirmeProjesi
//
//  Created by hamid karimli on 28.05.2025.
//
import SwiftUI

struct DiyetView2: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var calorieTracker: CalorieTracker
    @State private var showAssistant = false // 👈 Ekle

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

                // ✅ Floating Assistant Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showAssistant = true
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
