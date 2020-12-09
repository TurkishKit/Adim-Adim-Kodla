//
//  DailyLimitView.swift
//  Butce
//
//  Created by Can Balkaya on 10/9/20.
//

import SwiftUI

struct DailyLimitView: View {
    
    // MARK: - Properties
    @StateObject var sheetNavigator = SheetNavigator.shared
    @ObservedObject var budgetManager = BudgetManager.shared
    @Binding var showSheet: Bool
    @Binding var expenseLimit: Int
    
    // MARK: - UI Elements
    var body: some View {
        NavigationView {
            Form {
                Section(footer:
                    Text("Kendine bir para harcama limit koy.")
                ) {
                    NumberTextField(value: $expenseLimit)
                }
            }
            .navigationBarTitle("Günlük Limit Belirle", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        showSheet = false
                        sheetNavigator.dailyLimitViewIsPresented = false
                        sheetNavigator.addExpenseViewIsPresented = false
                    }) {
                        Text("Cancel")
                            .foregroundColor(.lightPurple)
                    }
                    .opacity(!BudgetManager.shared.isFirstLaunch ? 1 : 0)
                    .disabled(!BudgetManager.shared.isFirstLaunch ? false : true),
                
                trailing:
                    Button(action: {
                        showSheet = false
                        budgetManager.isFirstLaunch = false
                        budgetManager.changeExpenseLimit(newLimit: expenseLimit)
                    }) {
                        Text("Belirle")
                            .foregroundColor(.lightPurple)
                    }
            )
        }
        .onTapGesture {
            // Klavyeyi kapatır
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

struct DailyLimitView_Previews: PreviewProvider {
    static var previews: some View {
        DailyLimitView(showSheet: .constant(false), expenseLimit: .constant(1))
    }
}
