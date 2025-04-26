//
//  LevelViewHelper .swift
//  BitirmeProjesi
//
//  Created by hamid on 22.04.2025.
//

import SwiftUI
import SwiftData

struct LevelView: View {
    init(MaxValue: Double,safaIsmi:String,levelaciklamasi:String) {
        self.MaxValue = MaxValue
        self.sayfaIsmi = safaIsmi
        self.levelaciklamsi = levelaciklamasi
    }
    @Query private var records: [SporData]
    
    private var MaxValue: Double
    private var levelaciklamsi: String

    private var sayfaIsmi : String
    var exerciseTotals: [(exercise: String, total: Int)] {
        [
            ("Squat", records.reduce(0) { $0 + ($1.squat1 ?? 0) }),
            ("Biceps", records.reduce(0) { $0 + ($1.biceps ?? 0) }),
            ("Lunge Sol", records.reduce(0) { $0 + ($1.lungeSol ?? 0) }),
            ("Lunge Sag", records.reduce(0) { $0 + ($1.lungeSag ?? 0) }),
            ("Press", records.reduce(0) { $0 + ($1.press ?? 0) }),
            ("Standing", records.reduce(0) { $0 + ($1.standing ?? 0) })
        ]
    }
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing: 5){
                    Spacer().frame(height: 30)
                    
                    ForEach(exerciseTotals ,id: \.exercise){data in
                        LevelViewModel(current: data.total, sporadi:data.exercise, MaxValue: MaxValue, levelaciklamsi: levelaciklamsi)
                        
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
