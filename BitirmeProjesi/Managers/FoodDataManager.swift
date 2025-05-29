import Foundation
import SwiftData

class FoodDataManager {
    static let shared = FoodDataManager()
    
    private init() {}
    
    func loadFoodData(modelContext: ModelContext) {
        // Check if data is already loaded
        let descriptor = FetchDescriptor<Food>()
        if let count = try? modelContext.fetchCount(descriptor), count > 0 {
            print("Food data already loaded")
            return
        }
        
        // Read CSV file
        guard let csvPath = Bundle.main.path(forResource: "Food", ofType: "csv"),
              let csvString = try? String(contentsOfFile: csvPath, encoding: .utf8) else {
            print("Error: Could not find or read Food.csv")
            return
        }
        
        // Parse CSV
        let rows = csvString.components(separatedBy: .newlines)
        let headers = rows[0].components(separatedBy: ",")
        
        // Skip header row and process data
        for row in rows.dropFirst() where !row.isEmpty {
            let columns = row.components(separatedBy: ",")
            guard columns.count == headers.count else { continue }
            
            // Create Food object
            let food = Food(
                name: columns[0],
                portion: Double(columns[1]) ?? 0,
                energy: Double(columns[2]) ?? 0,
                fat: Double(columns[3]) ?? 0,
                carbohydrate: Double(columns[4]) ?? 0,
                protein: Double(columns[5]) ?? 0,
                sugar: Double(columns[6]) ?? 0,
                fiber: Double(columns[7]) ?? 0
            )
            
            // Save to SwiftData
            modelContext.insert(food)
        }
        
        // Save changes
        do {
            try modelContext.save()
            print("Successfully loaded food data into SwiftData")
        } catch {
            print("Error saving food data: \(error)")
        }
    }
    
    // Helper function to get all foods
    func getAllFoods(modelContext: ModelContext) -> [Food] {
        let descriptor = FetchDescriptor<Food>()
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching foods: \(error)")
            return []
        }
    }
    
    // Helper function to search foods by name
    func searchFoods(modelContext: ModelContext, query: String) -> [Food] {
        let descriptor = FetchDescriptor<Food>(
            predicate: #Predicate<Food> { food in
                food.name.localizedStandardContains(query)
            }
        )
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("Error searching foods: \(error)")
            return []
        }
    }
} 