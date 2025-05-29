import SwiftUI
import SwiftData

struct SearchDetailView: View {
    let food: Food
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var calorieTracker: CalorieTracker
    
    var body: some View {
        ZStack {
            ExtractedView.shared
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    headerSection
                    
                    // Nutritional Information
                    nutritionalInfoSection
                    
                    // Add to Meal Button
                    addToMealButton
                }
                .padding()
            }
        }
        .navigationTitle(food.name)
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    // Add to favorites action
                }) {
                    Image(systemName: "heart")
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            Image(systemName: "fork.knife.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.orange)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
            
            Text("\(Int(food.portion))g Porsiyon")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color("ButtonC"))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.2))
        )
        .modifier(CardModifier())
    }
    
    private var nutritionalInfoSection: some View {
        VStack(spacing: 20) {
            Text("Besin Değerleri")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color("ButtonC"))
            
            VStack(spacing: 16) {
                nutritionalRow(title: "Enerji", value: "\(Int(food.energy))", unit: "kcal", icon: "flame.fill", color: .orange)
                nutritionalRow(title: "Protein", value: "\(Int(food.protein))", unit: "g", icon: "p.circle.fill", color: .green)
                nutritionalRow(title: "Karbonhidrat", value: "\(Int(food.carbohydrate))", unit: "g", icon: "c.circle.fill", color: .blue)
                nutritionalRow(title: "Yağ", value: "\(Int(food.fat))", unit: "g", icon: "f.circle.fill", color: .red)
                nutritionalRow(title: "Şeker", value: "\(Int(food.sugar))", unit: "g", icon: "s.circle.fill", color: .purple)
                nutritionalRow(title: "Lif", value: "\(Int(food.fiber))", unit: "g", icon: "leaf.fill", color: .mint)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.2))
            )
            .modifier(CardModifier())
        }
    }
    
    private func nutritionalRow(title: String, value: String, unit: String, icon: String, color: Color) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 30)
            
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color("ButtonC"))
            
            Spacer()
            
            Text("\(value) \(unit)")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color("ButtonC"))
        }
    }
    
    private var addToMealButton: some View {
        Button(action: {
            calorieTracker.addCalories(food.energy)
            calorieTracker.addNutrition(protein: food.protein, fat: food.fat, carbs: food.carbohydrate)
            dismiss()
        }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Öğüne Ekle")
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue)
            )
        }
        .modifier(CardModifier())
    }
}

// Calorie Tracker class to manage calories across views
@MainActor
class CalorieTracker: ObservableObject {
    @Published var consumedCalories: Double = 0.0
    @Published var consumedProtein: Double = 0.0
    @Published var consumedFat: Double = 0.0
    @Published var consumedCarbs: Double = 0.0
    
    private let modelContext: ModelContext
    private var dailyNutrition: DailyNutrition?
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadTodayNutrition()
    }
    
    private func loadTodayNutrition() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        let descriptor = FetchDescriptor<DailyNutrition>(
            predicate: #Predicate<DailyNutrition> { nutrition in
                nutrition.date >= today && nutrition.date < tomorrow
            }
        )
        
        do {
            let results = try modelContext.fetch(descriptor)
            if let existing = results.first {
                dailyNutrition = existing
                updatePublishedValues()
            } else {
                // Create new daily nutrition record
                dailyNutrition = DailyNutrition(date: today)
                modelContext.insert(dailyNutrition!)
            }
        } catch {
            print("Error loading daily nutrition: \(error)")
        }
    }
    
    private func updatePublishedValues() {
        guard let nutrition = dailyNutrition else { return }
        consumedCalories = nutrition.consumedCalories
        consumedProtein = nutrition.consumedProtein
        consumedFat = nutrition.consumedFat
        consumedCarbs = nutrition.consumedCarbs
    }
    
    private func saveChanges() {
        guard let nutrition = dailyNutrition else { return }
        nutrition.consumedCalories = consumedCalories
        nutrition.consumedProtein = consumedProtein
        nutrition.consumedFat = consumedFat
        nutrition.consumedCarbs = consumedCarbs
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving daily nutrition: \(error)")
        }
    }
    
    func addCalories(_ calories: Double) {
        consumedCalories += calories
        saveChanges()
    }
    
    func addNutrition(protein: Double, fat: Double, carbs: Double) {
        consumedProtein += protein
        consumedFat += fat
        consumedCarbs += carbs
        saveChanges()
    }
    
    func resetDailyNutrition() {
        consumedCalories = 0
        consumedProtein = 0
        consumedFat = 0
        consumedCarbs = 0
        saveChanges()
    }
}

#Preview {
    let food = Food(
        name: "Örnek Yemek",
        portion: 100,
        energy: 250,
        fat: 10,
        carbohydrate: 30,
        protein: 15,
        sugar: 5,
        fiber: 3
    )
    return NavigationView {
        SearchDetailView(food: food)
            .environmentObject(CalorieTracker(modelContext: try! ModelContainer(for: DailyNutrition.self).mainContext))
    }
} 
