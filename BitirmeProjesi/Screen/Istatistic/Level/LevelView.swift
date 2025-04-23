//
//  LevelViewHelper .swift
//  BitirmeProjesi
//
//  Created by hamid on 22.04.2025.
//

import SwiftUI


struct LevelView: View {
    init(MaxValue: Double,safaIsmi:String) {
        self.MaxValue = MaxValue
        self.sayfaIsmi = safaIsmi
    }
    
    private var MaxValue: Double
    private var sayfaIsmi : String
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing: 5){
                    Spacer().frame(height: 30)
                    LevelViewModel(current: 12, sporadi: "Squat", MaxValue: MaxValue)
                    LevelViewModel(current: 12, sporadi: "Biceps", MaxValue: MaxValue)
                    LevelViewModel(current: 12, sporadi: "Lateral", MaxValue: MaxValue)
                    LevelViewModel(current: 12, sporadi: "Dumbell", MaxValue: MaxValue)
                    LevelViewModel(current: 12, sporadi: "LungSag", MaxValue: MaxValue)
                    LevelViewModel(current: 12, sporadi: "LungSol", MaxValue: MaxValue)
                    
                }   .padding()
                    
                    .navigationTitle(sayfaIsmi)
                    .navigationBarTitleDisplayMode(.inline)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all, edges: .all)
            .preferredColorScheme(.dark)
        }
        
       
    }
}

#Preview {
    LevelView(MaxValue: 10.0, safaIsmi: "Level1")
}
