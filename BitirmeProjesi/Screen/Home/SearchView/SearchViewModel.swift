//
//  SwiftUIView.swift
//  Diyet4oo
//
//  Created by hamid karimli on 6.05.2025.

import SwiftUI
import SwiftData
import Combine

/// ViewModel sınıfı, Core Data'dan `Food` entity'sini çekip arama metnine göre filtreleme yapar.
@MainActor
class SearchViewModel: ObservableObject {
    // MARK: - Constants
    private let fetchLimit: Int = 20
    private let searchDebounceTime: TimeInterval = 0.3

    // MARK: - Published Properties
    @Published var searchText1: String = ""
    @Published var filtered: [Food] = []
    @Published var isLoading: Bool = false

    // MARK: - Private Properties
    private let modelContext: ModelContext
    private var cancellables = Set<AnyCancellable>()
    private var searchTask: Task<Void, Never>?

    // MARK: - Initialization
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        setupSearchSubscription()
        Task {
            await loadInitialData()
        }
    }

    // MARK: - Setup
    private func setupSearchSubscription() {
        $searchText1
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.searchTask?.cancel()
                self?.searchTask = Task {
                    await self?.filterContent(for: text)
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - Data Loading
    private func loadInitialData() async {
        await filterContent(for: "")
    }

    // MARK: - Fetch & Filter
    private func filterContent(for text: String) async {
        guard !Task.isCancelled else { return }
        
        isLoading = true
        defer { isLoading = false }

        do {
            var descriptor = FetchDescriptor<Food>(
                predicate: text.isEmpty ? nil : #Predicate<Food> { food in
                    food.name.localizedStandardContains(text)
                },
                sortBy: [SortDescriptor(\.name)]
            )
            
            if text.isEmpty {
                descriptor.fetchLimit = fetchLimit
            }
            
            let result = try modelContext.fetch(descriptor)
            if !Task.isCancelled {
                self.filtered = result
            }
        } catch {
            print("Fetch error: \(error.localizedDescription)")
        }
    }

    @MainActor
    func performSearch(_ text: String) async {
        await filterContent(for: text)
    }
}
