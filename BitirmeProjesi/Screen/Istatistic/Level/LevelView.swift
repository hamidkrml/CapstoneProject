//
//  LevelViewHelper .swift
//  BitirmeProjesi
//
//  Created by hamid on 22.04.2025.
//

import SwiftUI
import SwiftData

struct LevelView: View {
    init(MaxValue: Double,safaIsmi:String) {
        self.MaxValue = MaxValue
        self.sayfaIsmi = safaIsmi
    }
    @Query private var records: [SporData]
    private var MaxValue: Double
    private var sayfaIsmi : String
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing: 5){
                    Spacer().frame(height: 30)
                    
                    ForEach(records){data in
                        LevelViewModel(current: data.squat1 ?? 0, sporadi: "Squat", MaxValue: MaxValue)
                        LevelViewModel(current: data.biceps ?? 0, sporadi: "Biceps", MaxValue: MaxValue)
                        LevelViewModel(current: data.standing ?? 0, sporadi: "Lateral", MaxValue: MaxValue)
                        LevelViewModel(current: data.press ?? 0, sporadi: "Dumbell", MaxValue: MaxValue)
                        LevelViewModel(current: data.lungeSag ?? 0, sporadi: "LungSag", MaxValue: MaxValue)
                        LevelViewModel(current: data.lungeSol ?? 0, sporadi: "LungSol", MaxValue: MaxValue)
                    }
                    
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
