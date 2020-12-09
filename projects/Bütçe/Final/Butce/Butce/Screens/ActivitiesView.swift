//
//  ActivitiesView.swift
//  Butce
//
//  Created by Can Balkaya on 10/10/20.
//

import SwiftUI

struct ActivitiesView: View {
    
    // MARK: - Properties
    @EnvironmentObject var budgetManager: BudgetManager
    
    // MARK: - UI Elements
    var body: some View {
        List {
            ForEach(
                budgetManager.expenses, id: \.id
            ) { expense in
                ExpenseListCellView(expense: expense)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .background(Color.darkBackground.edgesIgnoringSafeArea(.all))
        .navigationBarTitle("Tüm Harcamalar", displayMode: .inline)
    }
}

struct ActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView()
    }
}
