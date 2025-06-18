//
//  SwiftUIView.swift
//  BitirmeProjesi
//
//  Created by hamid on 03.01.25.
//

import SwiftUI

struct Lsolvid: View {
    
    @State var sol = false
    var body: some View {
        VStack(spacing:10){
            VideoPlayerToplu(videoad: "lsag")
            
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
            
            
            Spacer()
            
            Button(action:{
                sol = true
                
            }, label:{
                Buttongenel(adyaz: "Lunsol")
                
            })
            
        }.bgNavlink(content: Lungessol(), isAction: $sol)
            .frame(maxWidth: .infinity)
            .background(
                ExtractedView.shared
            )
            .preferredColorScheme(.dark)
    }
}

#Preview {
    Lsagvid()
}
