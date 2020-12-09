//
//  BudgetWidgetView.swift
//  ButceWidgetExtension
//
//  Created by Can Balkaya on 10/15/20.
//

import SwiftUI

struct CategoryWidgetView: View {
    
    // MARK: - Properties
    @Environment(\.widgetFamily) var family
    let model: BudgetEntry
    let budgetManager = BudgetManager.shared
    var remainingBalance: Int {
        model.expenseLimit - budgetManager.dailySpent
    }
    let layout = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    // MARK: - UI Elements
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemLarge:
            ZStack {
                Color.iconBackgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: -30) {
                    Text("Kategoriler")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.titleColor)
                        .padding(.leading, 30)
                        .padding(.top, 60)
                    
                    LazyVGrid(columns: layout, spacing: 20) {
                        ForEach(model.all.indices, id: \.self) { index in
                            CategoryItemView(category: model.all[index], amount: BudgetManager.shared.categoryAmounts[index])
                        }
                    }
                    .scaleEffect(0.72)
                }
            }
        
        case .systemMedium:
            ZStack {
                Color.iconBackgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: -5) {
                    Text("Kategoriler")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.titleColor)
                        .padding(.leading, 65)
                        .padding(.top, 15)
                    
                    HStack {
                        ForEach(0..<4) { index in
                            CategoryItemView(category: Category(name: model.all[index].name, icon: model.all[index].icon), amount: budgetManager.categoryAmounts[index])
                        }
                    }
                    .scaleEffect(0.7)
                }
            }
        
        case .systemSmall:
            ZStack {
                Color.iconBackgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 5) {
                    HStack {
                        Text("Kategori")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(.titleColor)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    
                    CategoryItemView(category: model.all[5], amount: budgetManager.categoryAmounts[5])
                        .scaleEffect(0.9)
                }
            }
            
        @unknown default:
            fatalError()
        }
    }
}
