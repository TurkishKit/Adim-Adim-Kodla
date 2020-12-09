//
//  Expense.swift
//  Butce
//
//  Created by Sergen Gonenc on 10/8/20.
//

import Foundation

struct Expense: Codable {
    
    // MARK: - Properties
    var id = UUID()
    let category: Category
    var amount: Int
    let date: Date
    let note: String
}
