//
//  LevelViewModel.swift
//  BitirmeProjesi
//
//  Created by hamid on 22.04.2025.
//

import SwiftUI

struct LevelViewModel: View {
    // MARK: - Initializer
       /// View'a dışarıdan `current` (mevcut seviye) ve `sporadi` (spor adı) gönderilir.
       /// Bu değerler `@State` olarak tanımlanır çünkü view içinde değişebilir olmaları istenir.
    init(current: Int, sporadi : String,MaxValue:Double) {
        _current = State(initialValue: current)
        _sporadi = State(initialValue: sporadi)
        _maxValue = State(initialValue: MaxValue)
    }
    
    @State private var minValue = 0.0
    @State private var maxValue :Double
    @State private var current: Int
    @State private var sporadi : String

    var body: some View {
        HStack{
            Rectangle()
                .frame(height: 0.6)
            Text(sporadi)
                .font(.footnote)
                .fontWeight(.semibold)
            Rectangle()
                .frame(height: 0.6)
            Spacer()
            circularCapacityGaugeColorful1
            Rectangle()
                .frame(height: 0.6)
        }
    }
    // MARK: - Gauge View
       /// Dairesel gauge bileşeni, kullanıcının seviyesini görsel olarak gösterir.
    @ViewBuilder
    private var circularCapacityGaugeColorful1: some View {
        Gauge(value: min(Double(current), maxValue), in: minValue...maxValue) {
            Image(systemName: "heart.fill")
                .foregroundStyle(.red)
        }currentValueLabel: {
            Text("\(Int(min(Double(current), maxValue)))")
                .foregroundStyle(.green)
        } minimumValueLabel: {
            Text("\(Int(minValue))")
                .foregroundStyle(.green)
        } maximumValueLabel: {
            Text("\(Int(maxValue))")
                .foregroundStyle(.red)
        }
        .gaugeStyle(.accessoryCircularCapacity)
    }
}

#Preview {
    LevelViewModel(current: 13, sporadi: "squat", MaxValue: 10.0)
}
