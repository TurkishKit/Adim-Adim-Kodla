//
//  SheetNavigator.swift
//  Butce
//
//  Created by Can Balkaya on 10/16/20.
//

import SwiftUI

class SheetNavigator: ObservableObject {
    
    // MARK: - Enumaretions
    enum SheetDestination {
        case dailyLimitView
        case addExpenseView
    }
    
    // MARK: - Properties
    static let shared = SheetNavigator()
    @Published var dailyLimitViewIsPresented = false
    @Published var addExpenseViewIsPresented = false
    var sheetDestination: SheetDestination = .addExpenseView
}
