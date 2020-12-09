//
//  ChartView.swift
//  Butce
//
//  Created by Can Balkaya on 10/10/20.
//

import SwiftUI

struct ChartView: View {
    
    // MARK: - Properties
    @EnvironmentObject var budgetManager: BudgetManager
    var expenseGroups: [[Expense]] { budgetManager.setExpenseGroups(true) }
    var expensesAreNotExist: Bool {
        var result = false
        for expenseGroup in expenseGroups {
            if !expenseGroup.isEmpty {
                result = true
            }
        }
        
        return result
    }
    
    // MARK: - UI Elements
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Rectangle()
                    .foregroundColor(.darkBackground)
                    .cornerRadius(8)
                Spacer()
            }
            
            HStack {
                HStack {
                    if expensesAreNotExist {
                        VStack(alignment: .trailing) {
                            let maxExpense = weekExpenses().max() ?? 0
                            let minExpense = weekExpenses().min() ?? 0
                            
                            Text("\(maxExpense)₺")
                            Spacer()
                            Text("\(((3 * maxExpense) + minExpense) / 4)₺")
                            Spacer()
                            Text("\((maxExpense + minExpense) / 2)₺")
                            Spacer()
                            Text("\((maxExpense + minExpense) / 4)₺")
                            Spacer()
                            Text("\(minExpense)₺")
                        }
                        .padding(.bottom, 24)
                        .padding(-8)
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                        .foregroundColor(.darkGray)
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            ForEach(-6...0, id: \.self) { index in
                                ColumnView(dayString: dayString(from: Date().daysAdded(index)), height: setHeights()[-index])
                            }
                        }
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(.darkGray)
                    } else {
                        HStack {
                            Text("Şu ana kadar herhangi bir harcama yapmadın. 💵")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 17, weight: .medium, design: .rounded))
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    // MARK: - Functions
    func dayString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "EE"
        dateFormatter.locale = Locale(identifier: "tr")
        
        return dateFormatter.string(from: date)
    }
    
    func setHeights() -> [Int] {
        let maxValue = weekExpenses().max()
        var resultHeights: [Int] = []
        
        for index in weekExpenses().indices {
            let resultHeight = Double(240 * weekExpenses()[index]) / Double((maxValue == 0 ? 1 : maxValue)!)
            resultHeights.append(Int(resultHeight))
        }
        
        return resultHeights
    }
    
    func weekExpenses() -> [Int] {
        var expenseAmounts: [Int] = []
        
        for groupIndex in expenseGroups.indices {
            let expenseCount = expenseGroups[groupIndex].count
            var expence = 0
            
            if !expenseGroups[groupIndex].isEmpty {
                for expenseIndex in 0..<expenseCount {
                    expence += expenseGroups[groupIndex][expenseIndex].amount
                }
            } else {
                expence = 0
            }
            
            expenseAmounts.append(expence)
        }
        
        print(expenseAmounts)
        
        return expenseAmounts
    }
}

struct ColumnView: View {
    
    // MARK: - Properties
    let dayString: String
    let height: Int
    
    // MARK: - UI Elements
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.lightPurple)
                .frame(width: 10, height: CGFloat(height))
                .cornerRadius(5)
            
            Text(dayString)
                .frame(width: 28)
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChartView()
                .modifier(PreviewViewModifier(colorScheme: .dark))
            
            ChartView()
                .modifier(PreviewViewModifier(colorScheme: .light))
        }
    }
}
