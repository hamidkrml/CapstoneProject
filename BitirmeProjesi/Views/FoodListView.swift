import SwiftUI
import SwiftData

struct FoodListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var foods: [Food]
    @State private var searchText = ""
    
    var filteredFoods: [Food] {
        if searchText.isEmpty {
            return foods
        } else {
            return FoodDataManager.shared.searchFoods(modelContext: modelContext, query: searchText)
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredFoods) { food in
                VStack(alignment: .leading) {
                    Text(food.name)
                        .font(.headline)
                    HStack {
                        Text("\(Int(food.energy)) kcal")
                            .foregroundColor(.orange)
                        Text("•")
                        Text("\(Int(food.portion))g")
                            .foregroundColor(.gray)
                    }
                    .font(.subheadline)
                }
            }
        }
        .searchable(text: $searchText, prompt: "Yemek ara...")
    }
} 