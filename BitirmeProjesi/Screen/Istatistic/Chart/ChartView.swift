import SwiftUI
import SwiftData
import Charts

struct SporChartView: View {
    // @Query ile veritabanındaki tüm SporData kayıtlarını otomatik çekiyoruz.
    @Query private var records: [SporData]
    
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
        VStack {
            Text("Toplam Spor Verileri")
                .font(.title2)
                .padding()
            
            Chart {
                ForEach(exerciseTotals, id: \.exercise) { item in
                    BarMark(
                        x: .value("Egzersiz", item.exercise),
                        y: .value("Toplam", item.total)
                    )
                    .foregroundStyle(.yellow.opacity(0.5))
                }
            }
            .frame(height: 300)
            .padding()
        }
        .chartXAxis {
            AxisMarks { _ in
                AxisValueLabel().foregroundStyle(.white)
            }
        }
        .chartYAxis {
            AxisMarks { _ in
                AxisValueLabel().foregroundStyle(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .background(ExtractedView.shared)
        .preferredColorScheme(.dark)
    }
}
