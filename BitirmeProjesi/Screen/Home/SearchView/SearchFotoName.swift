//
//  SearchFotoName.swift
//  Diyet4oo
//
//  Created by hamid karimli on 6.05.2025.
//
import SwiftUI

struct Searchuserfotoname: View {
    // MARK: - Properties
    let food: Food
    
    // MARK: - Body
    var body: some View {
        HStack {
            foodImage
            
            foodInfo
            
            Spacer()
        }
        .frame(height: 80)
        .padding(.horizontal)
    }
    
    // MARK: - UI Components
    
    private var foodImage: some View {
        Image(systemName: "swift")
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
    
    private var foodInfo: some View {
        VStack(alignment: .leading) {
            Text(food.name ?? "İsimsiz")
                .fontWeight(.semibold)
                .foregroundStyle(Color("ButtonC"))
            
            Text("\(Int(food.energy)) kcal")
                .foregroundStyle(Color("ButtonC"))
        }
        .font(.footnote)
    }
}

// MARK: - Preview

