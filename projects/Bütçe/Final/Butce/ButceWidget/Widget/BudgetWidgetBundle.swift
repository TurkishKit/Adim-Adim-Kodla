//
//  BudgetWidgetBundle.swift
//  Butce
//
//  Created by Can Balkaya on 11/1/20.
//

import SwiftUI
import WidgetKit

@main
struct BudgetWidgetBundle: WidgetBundle {
    
    // MARK: - UI Elements
    @WidgetBundleBuilder
    var body: some Widget {
        BudgetInfoWidget()
        CategoryWidget()
        ExpenseWidget()
    }
}
