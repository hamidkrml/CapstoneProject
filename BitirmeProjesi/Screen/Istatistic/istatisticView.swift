import SwiftUI
import SwiftData

struct istatisticView: View {
   
    @Query var records: [SporData]
    @State private var sheetShown = false
    var body: some View {

        NavigationStack {
            ScrollView {
                LazyVStack {
                    SporChartView()

                    Text("Aşamalar")
                        .font(.customfont(font: .Bold, fontSize: 25))
                        .foregroundColor(.white)
                    Button{
                        sheetShown = true
                    }label: {
                        productCard(image: "yemek", title: "level1")
                    }.sheet(isPresented: $sheetShown) {
                        Level1View(MaxValue: 15.0, safaIsmi: "level1")
                            .presentationDetents([.medium])
                    }
                   
                } 
                .navigationTitle("Level")
                
                .background (ExtractedView.shared)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all, edges: .all)
                .preferredColorScheme(.dark)
            }
            
        }
    }
    
    
}
