//
//  SwiftUIView.swift
//  BitirmeProjesi
//
//  Created by hamid on 03.01.25.
//

import SwiftUI

struct Lsagvid: View {
    
    @State var sag = false
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
            
            
            
            Spacer()
            
            Button(action:{
                sag = true
                
            }, label:{
                Buttongenel(adyaz: "Lunsag")
                
            })
            
        }.bgNavlink(content: Lungessag(), isAction: $sag)
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
