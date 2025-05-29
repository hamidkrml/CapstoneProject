//
//  ProductSider.swift
//  Diyet4oo
//
//  Created by hamid karimli on 8.05.2025.
//

import SwiftUI

struct SiderSearch: View {
    @State private var current = 10.0
    @State private var minValue = 0.0
    @State private var maxValue = 100.0
    var strokeColor: Color  // <-- Yeni eklenen renk değişkeni

    
    var ici : String
    var body: some View {
        VStack{
            

            Gauge(value: current, in: minValue...maxValue) {
                
                    
            } currentValueLabel: {
                Text("\(Int(current))")
            } minimumValueLabel: {
                Text("\(Int(minValue))")
            } maximumValueLabel: {
                Text("\(Int(current))")
            }
            .gaugeStyle(CustomGaugeStyle(maxValue: current, textgir: ici, strokeColor: strokeColor))
            
        }
        
    }
}
