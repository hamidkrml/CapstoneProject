//
//  CardViewYoga.swift
//  BitirmeProjesi
//
//  Created by hamid karimli on 17.06.2025.
//

import SwiftUI

struct CardViewYoga: View {
     //
    @State var bicep = false
    
    var body: some View {
        
        VStack(spacing:10){
            Spacer()
            VideoPlayerToplu(videoad: "yoga")
            
            Divider()
            
            VStack(spacing:20){
                Text(SporSayfalarinString.Yoga.localizede())
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                
            }
            Spacer()
     
        }
        .frame(maxWidth: .infinity)
        .background(
            ExtractedView.shared
        )
        .preferredColorScheme(.dark)
    }
}

#Preview {
    CardViewYoga()
}
