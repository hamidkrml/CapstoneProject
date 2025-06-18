import SwiftUI


struct Standingvid: View {
    
    
    @State var standing = false
    var body: some View {
        
        
        VStack(spacing:10){
            VideoPlayerToplu(videoad: "squatVideo")
            
            Divider()
            Spacer()
            VStack(spacing:30){
                Text("Kas geliştirme antrenmanlarında genellikle ilk uygulanan egzersizdir. Hormonların uyarılmasını sağlayarak vücudun kas yapmasına yardımcı olur. ")
                
                Text("Eger dogru Yapip yapmadiginizi Kontrol etmek istiyorsanizsa button tiklayarak AI ozeligili ile kactene yapa biliyosunuz deye kontrol ede bilirsinz")
            }
            .font(.title3)
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            
            
            
            Spacer()
            
            Button(action:{
                standing = true
                
            }, label:{
                Buttongenel(adyaz: "lateralDene")
                
            })
            
        }.bgNavlink(content: Standing(), isAction: $standing)
        
            .frame(maxWidth: .infinity)
            .background(
                ExtractedView.shared
            )
            .preferredColorScheme(.dark)
            
     
    }
}
