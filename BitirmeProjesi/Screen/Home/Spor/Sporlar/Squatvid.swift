import SwiftUI

struct Squatvid: View {
    @State var squat = false
    var body: some View {
        VStack(spacing:10){
            VideoPlayerToplu(videoad: "squatVideo")
            
            Divider()
            Spacer()
            VStack(spacing:20){
                Text("Kas geliştirme antrenmanlarında genellikle ilk uygulanan egzersizdir. Hormonların uyarılmasını sağlayarak vücudun kas yapmasına yardımcı olur. ")
                
                Text("Eger dogru Yapip yapmadiginizi Kontrol etmek istiyorsanizsa button tiklayarak AI ozeligili ile kactene yapa biliyosunuz deye kontrol ede bilirsinz")
            }
            .font(.title3)
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            
//            .onAppear{
//                NetworkMeneger.shared.getuser{ result in
//                    switch result{
//                    case .success(let success):
//                        success.forEach{ User in
//                            
//                            print(User.az?.description ?? "hamit")
//                        }
//                    case .failure(let failure):
//                        print(failure.localizedDescription)
//                    }
//                }
//                
//            }
            
            Spacer()
            
            Button(action:{
                squat = true
                
            }, label:{
                Buttongenel(adyaz: "squatDene")
                
            })
            
        }.bgNavlink(content: SquatView(), isAction: $squat)
            .frame(maxWidth: .infinity)
            .background(
                ExtractedView.shared
            )
            .preferredColorScheme(.dark)
    }
    
}
