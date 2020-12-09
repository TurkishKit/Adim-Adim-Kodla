//
//  ExpenseWidgetView.swift
//  Butce
//
//  Created by Can Balkaya on 11/1/20.
//

import SwiftUI
import WidgetKit

struct ExpenseWidgetView: View {
    
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
                
                if model.expenses.count > 8 {
                    VStack(alignment: .leading, spacing: -30) {
                        Text("Son Harcamaların")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(.titleColor)
                            .padding(.leading, 30)
                            .padding(.top, 60)
                        
                        LazyVGrid(columns: layout, spacing: 20) {
                            ForEach(model.expenses.indices, id: \.self) { index in
                                CategoryItemView(category: model.expenses[index].category, amount: model.expenses[index].amount)
                            }
                        }
                        .scaleEffect(0.72)
                    }
                } else {
                    Text("8'den fazla harcama yapmadın. 🤑")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                }
            }
        
        case .systemMedium:
            ZStack {
                Color.iconBackgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                if model.expenses.count > 3 {
                    VStack(alignment: .leading, spacing: -5) {
                        Text("Son Harcamaların")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(.titleColor)
                            .padding(.leading, 65)
                            .padding(.top, 15)
                    
                        HStack {
                            ForEach(0..<4) { index in
                                CategoryItemView(category: model.expenses[index].category, amount: model.expenses[index].amount)
                            }
                        }
                        .scaleEffect(0.7)
                    }
                } else {
                    Text("3'den fazla harcama yapmadın. 💸")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                }
            }
        
        case .systemSmall:
            ZStack {
                Color.iconBackgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                if model.expenses.count > 1 {
                    VStack(spacing: 5) {
                        HStack {
                            Text("Son Harcaman")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundColor(.titleColor)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        CategoryItemView(category: model.expenses[0].category, amount: model.expenses[0].amount)
                            .scaleEffect(0.9)
                    }
                } else {
                    Text("Şu ana kadar herhangi bir harcama yapmadın. 💵")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                }
            }
            
        @unknown default:
            fatalError()
        }
    }
}
