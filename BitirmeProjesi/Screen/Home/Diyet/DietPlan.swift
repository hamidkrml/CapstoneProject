import Foundation

struct DietPlan: Codable {
    let meals: Meals
    let total_calories: Int
}

struct Meals: Codable {
    let breakfast: String
    let lunch: String
    let dinner: String
} 