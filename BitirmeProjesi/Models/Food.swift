import Foundation
import SwiftData

@Model
final class Food {
    var name: String
    var portion: Double
    var energy: Double
    var fat: Double
    var carbohydrate: Double
    var protein: Double
    var sugar: Double
    var fiber: Double
    
    init(name: String, portion: Double, energy: Double, fat: Double, carbohydrate: Double, protein: Double, sugar: Double, fiber: Double) {
        self.name = name
        self.portion = portion
        self.energy = energy
        self.fat = fat
        self.carbohydrate = carbohydrate
        self.protein = protein
        self.sugar = sugar
        self.fiber = fiber
    }
} 