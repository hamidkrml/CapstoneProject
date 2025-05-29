//
//  DiyetSider.swift
//  BitirmeProjesi
//
//  Created by hamid karimli on 28.05.2025.
//

import SwiftUI
import SwiftData

struct ProductSider: View {
    // MARK: - Properties
    @State private var current = 0.0
    @State private var minValue = 0.0
    @EnvironmentObject var calorieTracker: CalorieTracker
    
    // MARK: - Computed Properties
    
    /// Target calories from user profile or default value
    @Query private var kullanicilar: [KullanciBilgileri]
    var hedefKalori: Double {
        if let kaloriStr = kullanicilar.first?.dailyCalorieNeed,
           let kalori = Double(kaloriStr) {
            return kalori
        }
        return 200.0
    }
    
    /// Remaining calories calculation
    var kalanKalori: Double {
        hedefKalori - calorieTracker.consumedCalories
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 16) {
            Text("Kalori Takibi")
                .font(.title2)
                .fontWeight(.bold)
            
            // Calorie tracking section
            calorieTrackingSection
                .padding(.vertical, 8)
            
            // Nutrition information section
            nutritionInfoSection
                .padding(.vertical, 4)
            
            Spacer()
        }
        .padding(.vertical, 16)
        .background(Color.white.opacity(0.2))
        .modifier(CardModifier())
    }
    
    // MARK: - UI Components
    
    /// Calorie tracking section with gauge
    private var calorieTrackingSection: some View {
        HStack(spacing: 20) {
            Spacer()
            
            calorieInfoView(value: "\(Int(calorieTracker.consumedCalories))", label: "Alınan")
            
            Spacer()
            
            calorieGauge
            
            Spacer()
            
            calorieInfoView(value: "\(Int(kalanKalori))", label: "Kalan")
            
            Spacer()
        }
    }
    
    /// Nutrition information section
    private var nutritionInfoSection: some View {
        HStack(spacing: 40) {
            nutritionInfoView(label: "Karbonhidrat", value: "\(Int(calorieTracker.consumedCarbs))g")
            nutritionInfoView(label: "Protein", value: "\(Int(calorieTracker.consumedProtein))g")
            nutritionInfoView(label: "Yağ", value: "\(Int(calorieTracker.consumedFat))g")
        }
        .padding(.horizontal)
    }
    
    /// Calorie gauge
    private var calorieGauge: some View {
        Gauge(value: calorieTracker.consumedCalories, in: minValue...hedefKalori) {
            // Empty gauge content
        } currentValueLabel: {
            Text("\(Int(calorieTracker.consumedCalories))")
        } minimumValueLabel: {
            Text("\(Int(minValue))")
        } maximumValueLabel: {
            Text("\(Int(hedefKalori))")
        }
        .gaugeStyle(CustomGaugeStyle(maxValue: hedefKalori, textgir: "Kalan Kcal", strokeColor: Color.blue))
    }
    
    /// Calorie information view
    private func calorieInfoView(value: String, label: String) -> some View {
        VStack {
            Text(value)
                .font(.headline)
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
    
    /// Nutrition information view
    private func nutritionInfoView(label: String, value: String) -> some View {
        VStack {
            Text(label)
                .font(.footnote)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
        }
    }
}
