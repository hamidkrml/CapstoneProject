//
//  SwiftUIView.swift
//  BitirmeProjesi
//
//  Created by hamid karimli on 28.05.2025.
//

import SwiftUI


struct CustomGaugeStyle: GaugeStyle {
    var maxValue: Double
    var textgir : String
    var strokeColor: Color
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            
            
            ZStack {
                // Arka plan dairesi (tam gri çember)
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(configuration.value))
                    .stroke(strokeColor, lineWidth: 8)
                    .rotationEffect(.degrees(-90))
                VStack(spacing: 1){
                    Text("\(Int(max(0, maxValue - (configuration.value * maxValue))))  ")                    .font(.title2)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color("ButtonC"))
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                    
                    
                    Text(textgir)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("ButtonC"))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    
                }
                
            }
            
            .frame(width: 110,height: 120)
            
            
        }
    }
}
