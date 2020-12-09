//
//  SimpleEntry.swift
//  ButceWidgetExtension
//
//  Created by Can Balkaya on 10/15/20.
//

import WidgetKit

struct BudgetEntry: Codable, TimelineEntry {
    
    // MARK: - Properties
    var date = Date()
    let expenses: [Expense]
    let all: [Category]
    let expenseLimit: Int
    
    static let placeholderSimpleEntry = BudgetEntry(expenses: [Expense(category: Category.all[0], amount: 10, date: Date(), note: "Deneme 1"), Expense(category: Category.all[1], amount: 12, date: Date(), note: "Deneme 2"), Expense(category: Category.all[1], amount: 12, date: Date(), note: "Deneme 3"), Expense(category: Category.all[1], amount: 12, date: Date(), note: "Deneme 4"), Expense(category: Category.all[1], amount: 12, date: Date(), note: "Deneme 5"), Expense(category: Category.all[1], amount: 12, date: Date(), note: "Deneme 6"), Expense(category: Category.all[1], amount: 12, date: Date(), note: "Deneme 7"), Expense(category: Category.all[1], amount: 12, date: Date(), note: "Deneme 8"), Expense(category: Category.all[1], amount: 12, date: Date(), note: "Deneme 9")], all: Category.all, expenseLimit: 40)
}
