//
//  DiyetCard.swift
//  BitirmeProjesi
//
//  Created by hamid karimli on 28.05.2025.
//


import SwiftUI

/// A card view that displays meal information and allows adding items
struct DiyetCard: View {
    // MARK: - Properties
    let image: String
    let title: String
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 16) {
            // Left content
            VStack(alignment: .leading, spacing: 12) {
                headerContent
                recommendedCaloriesText
            }
            
            Spacer()
            
            // Add button
            addButton
        }
        .frame(height: 100)
        .padding(.horizontal, 16)
        .background(Color.white.opacity(0.2))
        .modifier(CardModifier())
        
    }
    
    // MARK: - UI Components
    
    /// Header content with image and title
    private var headerContent: some View {
        HStack(spacing: 12) {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
            
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)
        }
    }
    
    /// Recommended calories text
    private var recommendedCaloriesText: some View {
        HStack {
            Image(systemName: "flame.fill")
                .foregroundColor(.orange)
            Text("Önerilen Kcal")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)
        }
    }
    
    /// Add button
    private var addButton: some View {
        Button(action: {
            // Add action here
        }) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                
                
                .clipShape(Circle())
        }
    }
}
