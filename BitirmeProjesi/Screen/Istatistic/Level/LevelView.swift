//
//  LevelViewHelper .swift
//  BitirmeProjesi
//
//  Created by hamid on 22.04.2025.
//

import SwiftUI
import SwiftData

struct LevelView: View {
    init(MaxValue: Double,safaIsmi:String,levelaciklamasi:String,records: [SporData]) {
        self.MaxValue = MaxValue
        self.sayfaIsmi = safaIsmi
        self.levelaciklamsi = levelaciklamasi
        _exerciseManager = StateObject(wrappedValue: ExerciseTotalsManager(records: records))
    }
    @Query private var records: [SporData]
    
    private var MaxValue: Double
    private var levelaciklamsi: String

    private var sayfaIsmi : String
    @StateObject private var exerciseManager: ExerciseTotalsManager

    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing: 5){
                    Spacer().frame(height: 30)
                    Text(levelaciklamsi)
                        .font(.footnote)
                        .fontWeight(.semibold)
                    ForEach(exerciseManager.exerciseTotals ,id: \.exercise){data in
                        LevelViewModel(current: data.total, sporadi:data.exercise, MaxValue: MaxValue, levelaciklamsi: "")
                        
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

//#Preview {
//    LevelView(MaxValue: 10.0, safaIsmi: "Level1")
//}
