//
//  BudgetInfoWidgetView.swift
//  Butce
//
//  Created by Can Balkaya on 11/1/20.
//

import SwiftUI
import WidgetKit

struct BudgetInfoWidgetView: View {
    
    // MARK: - Properties
    @Environment(\.widgetFamily) var family
    let model: BudgetEntry
    let budgetManager = BudgetManager.shared
    var remainingBalance: Int {
        model.expenseLimit - budgetManager.dailySpent
    }
    
    // MARK: - UI Elements
    @ViewBuilder
    var body: some View {
        ZStack {
            Color.iconBackgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10) {
                VStack(spacing: 5) {
                    Text("\(budgetManager.dailySpent)₺")
                        .font(.system(size: 25, weight: .heavy, design: .rounded))
                    
                    Text("Bugün Harcanan")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.darkGray)
                }
                
                Divider()
                    .frame(width: 100)
                
                VStack(spacing: 5) {
                    Text("Kalan")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.darkGray)
                    
                    Text("\(remainingBalance)₺")
                        .font(.system(size: 21, weight: .heavy, design: .rounded))
                        .foregroundColor(remainingBalance > 0 ? .lightGreen : .red)
                }
            }
        }
    }
}
