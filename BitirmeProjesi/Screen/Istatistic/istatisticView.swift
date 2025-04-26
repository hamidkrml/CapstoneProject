import SwiftUI
import SwiftData

struct istatisticView: View {
    
    @Query var records: [SporData]
    @State private var level1 = false
    @State private var level2 = false
    @State private var level3 = false
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
        
        NavigationStack {
            ScrollView {
                LazyVStack {
                    SporChartView()
                    
                    Text("Aşamalar")
                        .font(.customfont(font: .Bold, fontSize: 25))
                        .foregroundColor(.white)
                    
                    Divider()
                    
                    Button{
                        level1 = true
                    }label: {
                        productCard(image: "images1", title: "level1")
                    }.sheet(isPresented: $level1) {
                        
                        LevelView(MaxValue: 10.0, safaIsmi: "level1", levelaciklamasi: "Level 2 gecmek ici in Tum sporlardan 8 tane yapilmasi gerekiyor ")
                            .presentationDetents([.medium])
                        
                    }
                    
                    Button{
                        level2 = true
                    }label: {
                        productCard(image: "images2", title: "level2")
                    }.sheet(isPresented: $level2) {
                        
                        LevelView(MaxValue: 20.0, safaIsmi: "level2", levelaciklamasi: "Level 3 gecmek ici in Tum sporlardan 15 tane yapilmasi gerekiyor ")
                            .presentationDetents([.medium])
                    }
                    
                    .disabled(exerciseTotals.reduce(0) { $0 + $1.total } < 80)
                    .opacity(exerciseTotals.reduce(0) { $0 + $1.total } < 80 ? 0.5 : 1)
                    Button{
                        level3 = true
                    }label: {
                        productCard(image: "images3", title: "level3")
                    }.sheet(isPresented: $level3) {
                        LevelView(MaxValue: 30.0, safaIsmi: "level3", levelaciklamasi: "son Level Yetisdiniz Basarilar ")
                            .presentationDetents([.medium])
                        
                    }
                    .disabled(exerciseTotals.reduce(0) { $0 + $1.total } < 100)
                    .opacity(exerciseTotals.reduce(0) { $0 + $1.total } < 100 ? 0.5 : 1)
                    
                    
                }
                
            }
            .navigationTitle("Level")
            
            .background (ExtractedView.shared)
            
            
            .preferredColorScheme(.dark)
            
        }
    }
}
