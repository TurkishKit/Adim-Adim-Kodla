//
//  BudgetItemProvider.swift
//  Butce
//
//  Created by Can Balkaya on 10/12/20.
//

import SwiftUI

class ExpenseProvider: ObservableObject {
    
    // MARK: - Properties
    static let shared = ExpenseProvider()
    private let dataSourceURL: URL
    var expenses: [Expense] {
        get {
            do {
                let decoder = PropertyListDecoder()
                let data = try Data(contentsOf: dataSourceURL)
                let decodedReminders = try! decoder.decode([Expense].self, from: data)
                
                return decodedReminders
            } catch {
                return []
            }
        }
        set {
            do {
                let encoder = PropertyListEncoder()
                let data = try encoder.encode(newValue)
                
                try data.write(to: dataSourceURL)
            } catch {
                
            }
        }
    }
    
    // MARK: - Life Cycle
    init() {
        /// Bir projede birden çok döküman olabilir, ama bizim projemizde sadece bir tane döküman olduğundan o değeri tanımlayabilmek için "[0]" işaretini kullandık.
        let documentsPath = FileManager.sharedContainerURL()
        let remindersPath = documentsPath.appendingPathComponent("expenses").appendingPathExtension("json")
        
        dataSourceURL = remindersPath
    }
    
    // MARK: - Functions
    func getAllExpenses() -> [Expense] {
        return expenses
    }
    
    func createExpense(expense: Expense) {
        expenses.insert(expense, at: 0)
    }
}
