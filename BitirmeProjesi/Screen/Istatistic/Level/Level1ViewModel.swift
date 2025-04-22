//
//  LevelViewHelper .swift
//  BitirmeProjesi
//
//  Created by hamid on 22.04.2025.
//

import SwiftUI

struct Level1ViewModel: View {
    var body: some View {
        VStack(spacing: 15){
            LevelViewModel(current: 12, sporadi: "Squat")
            LevelViewModel(current: 12, sporadi: "Biceps")
            LevelViewModel(current: 12, sporadi: "Lateral")
            LevelViewModel(current: 12, sporadi: "Dumbell")
            LevelViewModel(current: 12, sporadi: "LungSag")
            LevelViewModel(current: 12, sporadi: "LungSol")

        }.padding()
    }
}

#Preview {
    Level1ViewModel()
}
