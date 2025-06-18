
import SwiftUI

struct Bicepvid: View {
    @Environment(\.modelContext) var modelContext //
    @State var bicep = false
    
    var body: some View {
        
        VStack(spacing:10){
            
            VideoPlayerToplu(videoad: "dumbelpress")
            
            Divider()
            Spacer()
            VStack(spacing:20){
                Text(SporSayfalarinString.biceps.localizede())
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
            }
            
            
            
            
            Spacer()
            
            
            NavigationLink(destination: BicepsView())
            {
                Buttongenel(adyaz: "Biceps")
            }.navigationTitle("Biceps Sayfasi")
            
        }
        .frame(maxWidth: .infinity)
        .background(
            ExtractedView.shared
        )
        .preferredColorScheme(.dark)
    }
}

