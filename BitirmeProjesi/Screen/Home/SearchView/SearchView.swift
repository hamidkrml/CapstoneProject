//
//  SearchView.swift
//  Diyet4oo
//
//  Created by hamid karimli on 6.05.2025.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    // MARK: - Properties
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: SearchViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject private var keyboard = KeyboardObserver()
    @EnvironmentObject var calorieTracker: CalorieTracker
    
    // MARK: - Initialization
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                searchBar
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else {
                    searchResults
                }
            }
            .navigationTitle("Yemekler")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
            }
            .background(
                ExtractedView.shared
                    .ignoresSafeArea()
            )
        }
        .navigationViewStyle(.stack)
    }
    
    // MARK: - UI Components
    
    private var searchBar: some View {
        TextField("Yemek ara...", text: $viewModel.searchText1)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding([.horizontal, .top])
    }
    
    private var searchResults: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                if viewModel.filtered.isEmpty {
                    emptyStateView
                } else {
                    resultsList
                }
            }
            .animation(keyboard.isKeyboardVisible ? nil : .default, value: viewModel.filtered)
            .padding(.horizontal)
        }
    }
    
    private var emptyStateView: some View {
        Text("Sonuç bulunamadı")
            .foregroundColor(.gray)
            .padding()
    }
    
    private var resultsList: some View {
        ForEach(viewModel.filtered) { food in
            NavigationLink(destination: SearchDetailView(food: food)
                .environmentObject(calorieTracker)) {
                Searchuserfotoname(food: food)
                    .padding(.vertical, 8)
            }
        }
    }
}

// MARK: - Preview


extension View {
    func withoutAnimation() -> some View {
        withAnimation(nil) {
            self
        }
    }
}
