//
//  ExpenseListView.swift
//  Butce
//
//  Created by Can Balkaya on 10/9/20.
//

import SwiftUI

struct ExpenseListView: View {
    
    // MARK: - Properties
    @EnvironmentObject var budgetManager: BudgetManager
    var expenseGroups: [[Expense]] { budgetManager.setExpenseGroups(false) }
    let isDetailButtonActive: Bool
    
    // MARK: - UI Elements
    var body: some View {
        VStack(spacing: 20) {
            ForEach(expenseGroups.indices, id: \.self) { index in
                ExpenseListSectionView(title: "\(dateString(from: expenseGroups[index][0].date))", expenses: expenseGroups[index])
            }
            
            if isDetailButtonActive {
                NavigationLink(destination: ActivitiesView()) {
                    Text("Tüm Harcamalar")
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .padding(.horizontal, 80)
                        .padding(.vertical, 15)
                        .background(
                            Rectangle()
                                .cornerRadius(30)
                                .foregroundColor(.lightPurple)
                        )
                }
            }
        }
        .padding()
        .background(
            Rectangle()
                .foregroundColor(.darkBackground)
                .cornerRadius(8)
        )
    }
    
    // MARK: - Functions
    func dateString(from date: Date) -> String {
        let dayDateFormatter = DateFormatter()
        dayDateFormatter.dateFormat = "d MMMM, yyyy"
        dayDateFormatter.locale = Locale(identifier: "tr")
        
        return dayDateFormatter.string(from: date)
    }
}

struct ExpenseListSectionView: View {
    
    // MARK: - Properties
    let title: String
    let expenses: [Expense]
    
    // MARK: - UI Elements
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(.darkGray)
            
            ForEach(expenses, id: \.id) { expense in
                ExpenseListCellView(expense: expense)
            }
        }
    }
}

struct ExpenseListCellView: View {
    
    // MARK: - Properties
    let id = UUID()
    let expense: Expense
    
    // MARK: - UI Elements
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Rectangle()
                        .frame(width: 54, height: 54)
                        .cornerRadius(16)
                        .foregroundColor(.iconBackgroundColor)
                    
                    Text(expense.category.icon)
                        .font(.system(size: 30))
                }
                
                VStack(alignment: .leading) {
                    Text(expense.category.name)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(.titleColor)
                    
                    if !expense.note.isEmpty {
                        Text(expense.note)
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundColor(.darkGray)
                    }
                }
                
                Spacer()
                
                Text("\(expense.amount)₺")
                    .foregroundColor(.red)
                    .font(.system(size: 15, weight: .heavy, design: .rounded))
            }
        }
    }
}

struct ExpenseListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExpenseListView(isDetailButtonActive: true)
                .modifier(PreviewViewModifier(colorScheme: .dark))
            
            ExpenseListView(isDetailButtonActive: true)
                .modifier(PreviewViewModifier(colorScheme: .light))
        }
    }
}
