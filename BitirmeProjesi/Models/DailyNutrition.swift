import Foundation
import SwiftData

@Model
class DailyNutrition {
    var date: Date
    var consumedCalories: Double
    var consumedProtein: Double
    var consumedFat: Double
    var consumedCarbs: Double
    
    init(date: Date = Date(), consumedCalories: Double = 0, consumedProtein: Double = 0, consumedFat: Double = 0, consumedCarbs: Double = 0) {
        self.date = date
        self.consumedCalories = consumedCalories
        self.consumedProtein = consumedProtein
        self.consumedFat = consumedFat
        self.consumedCarbs = consumedCarbs
    }
} 