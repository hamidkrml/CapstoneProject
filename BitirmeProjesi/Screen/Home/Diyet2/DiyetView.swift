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
    
    var body: some View {
        NavigationView {
            ZStack {
                ExtractedView.shared
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 10) {
                        Spacer()
                        Divider()
                        
                        // Daily calorie tracking section
                        ProductSider()
                            .environmentObject(calorieTracker)
                        
                        Spacer()
                        
                        // Meal navigation sections
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
            }
            .navigationTitle("Bugün")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    calendarButton
                }
            }
        }
    }
    
    // MARK: - UI Components
    
    /// Calendar button in the navigation bar
    private var calendarButton: some View {
        Button(action: {
            print("Takvim butonuna tıklandı")
        }) {
            Image(systemName: "calendar.and.person")
        }
    }
    
    /// Creates a navigation section for a meal
    private func mealNavigationSection(title: String, image: String) -> some View {
        NavigationLink {
            SearchView(viewModel: SearchViewModel(modelContext: modelContext))
        } label: {
            DiyetCard(image: image, title: title)
        }
    }
}
