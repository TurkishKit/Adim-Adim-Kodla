//
//  BudgetManager.swift
//  Butce
//
//  Created by Can Balkaya on 10/12/20.
//

import SwiftUI
import WidgetKit

class BudgetManager: ObservableObject {
    
    // MARK: - Properties
    static let shared = BudgetManager()
    private let currentDay = Date().dayComponent()
    private let dataSourceURL: URL
    @Published var expenses = [Expense]()
    
    var dailySpent: Int {
        var result = 0
        let expenses = totalExpenses(between: DateInterval(start: Date().daysAdded(-6), end: Date()))
        
        for expense in expenses {
            let date = Date().dayComponent()
            if date == expense.date.dayComponent() {
                result += expense.amount
            }
        }
        
        return result
    }
    var categoryAmounts: [Int] {
        let categories = Category.all
        var expenseGroups = [[Expense]]()
        var categoryAmounts = [Int]()
        
        for index in categories.indices {
            let newExpenseGroup = totalExpenses(between: DateInterval(start: Date().daysAdded(-6), end: Date())).filter({ return $0.category.name == categories[index].name })
            expenseGroups.insert(newExpenseGroup, at: 0)
        }
        
        for expenseGroup in expenseGroups {
            var categoryAmount = 0
            
            for expense in expenseGroup {
                categoryAmount += expense.amount
            }
            
            categoryAmounts.insert(categoryAmount, at: 0)
        }
        
        return categoryAmounts
    }
    @AppStorage("isFirstLaunch") var isFirstLaunch = true
    @AppStorage("expenseLimit", store: UserDefaults(suiteName: FileManager.appIdentifier)) var expenseLimit: Int = 0
    
    // MARK: - Life Cycle
    init() {
        let documentsPath = FileManager.sharedContainerURL()
        let expensesPath = documentsPath.appendingPathComponent("expenses").appendingPathExtension("json")
        dataSourceURL = expensesPath
        expenses = getExpenses()
    }
    
    // MARK: - Functions
    private func getExpenses() -> [Expense] {
        do {
            let decoder = PropertyListDecoder()
            let data = try Data(contentsOf: dataSourceURL)
            let decodedExpenses = try! decoder.decode([Expense].self, from: data)
            
            return decodedExpenses
        } catch {
            return []
        }
    }
    
    private func setExpenses(expenses: [Expense]) {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(expenses)
            try data.write(to: dataSourceURL)
        } catch {

        }
    }
    
    func totalExpenses(between dates: DateInterval) -> [Expense] {
        let startTimeIntervalSinceNow = Int(dates.start.timeIntervalSinceNow)
        let endTimeIntervalSinceNow = Int(dates.end.timeIntervalSinceNow)
        
        return expenses.filter({ return Int($0.date.timeIntervalSinceNow) >= startTimeIntervalSinceNow && Int($0.date.timeIntervalSinceNow) <= endTimeIntervalSinceNow })
    }
    
    func changeExpenseLimit(newLimit: Int) {
        expenseLimit = newLimit
    }
    
    func createExpense(_ expense: Expense) {
        expenses.insert(expense, at: 0)
        setExpenses(expenses: expenses)
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func setExpenseGroups(_ emptyArraysAreExist: Bool) -> [[Expense]] {
        var expenseGroups: [[Expense]] = []
        
        for index in -6...0 {
            let expenseGroup = totalExpenses(between: DateInterval(start: Date().daysAdded(-6), end: Date())).filter({ return $0.date.dayComponent() == Date().daysAdded(index).dayComponent() })
            
            if !expenseGroup.isEmpty {
                expenseGroups.insert(expenseGroup, at: 0)
            } else {
                if emptyArraysAreExist {
                    expenseGroups.insert(expenseGroup, at: 0)
                }
            }
        }

        return expenseGroups
    }
}
