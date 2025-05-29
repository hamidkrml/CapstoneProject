//
//  productCard.swift
//  BitirmeProjesi
//
//  Created by hamid on 22.02.25.
//

import SwiftUI

struct productCard: View {
    var image : String
    var title : String
    var decription : String = ""
    var body: some View {
        ZStack {
            
            HStack(alignment: .center){
                Image(image)
                    .resizable()
                //                    .aspectRatio( contentMode: .fit)
                    .frame(width: 70,height: 70)
                    .padding(.all,20)
                VStack{
                    Text(title)
                    
                        .font(.customfont(font: .light, fontSize: 22))
                        .foregroundColor(.white)
                    
                    HStack{
                        Text(decription)
                            .font(.customfont(font: .light, fontSize: 16))
                            .foregroundColor(.white)
                        
                    }
                    
                }.padding(.trailing, 20)
                Spacer()
            }
            
            .background(Color.white.opacity(0.2))
            .modifier(CardModifier())
            .padding(.all, 20)
        }
    }
}

#Preview {
    productCard(image: "yemek2", title: "asdsad", decription: "sadasdasdsada")
}
