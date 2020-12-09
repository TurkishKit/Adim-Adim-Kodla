//
//  CategoryItemView.swift
//  Butce
//
//  Created by Can Balkaya on 10/10/20.
//

import SwiftUI

struct CategoryItemView: View {
    
    // MARK: - Properties
    var category: Category
    let amount: Int
    
    // MARK: - UI Elements
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.darkBackground)
                .cornerRadius(8)
                .frame(width: 100, height: 120)
            
            VStack(spacing: 16) {
                Text("\(category.icon)")
                    .font(.system(size: 40))
                
                VStack(spacing: 18) {
                    Text("\(amount)₺")
                        .padding(-10)
                        .font(.system(size: 15, weight: .heavy, design: .rounded))
                        .foregroundColor(.titleColor)
                    
                    Text("\(category.name)".uppercased())
                        .padding(-8)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(.darkGray)
                }
            }
        }
    }
}

struct CategoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryItemView(category: Category(name: "Alışveriş", icon: "👚"), amount: 20)
                .modifier(PreviewViewModifier(colorScheme: .dark))
            
            CategoryItemView(category: Category(name: "Alışveriş", icon: "👚"), amount: 20)
                .modifier(PreviewViewModifier(colorScheme: .light))
        }
    }
}
