//
//  HomePageView.swift
//  Butce
//
//  Created by Sergen Gonenc on 10/8/20.
//

import SwiftUI

struct ExpenseView: View {
    
    // MARK: - Properties
    @ObservedObject var sheetNavigator = SheetNavigator.shared
    @EnvironmentObject var budgetManager: BudgetManager
    @State var expenseLimit = BudgetManager.shared.expenseLimit
    @State var showSheet = false
    
    // MARK: - UI Elements
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 40) {
                    BudgetInfoView(dailySpent: budgetManager.dailySpent, expenseLimit: $expenseLimit)
                        .padding(.top, 25)
            
                    if budgetManager.setExpenseGroups(false).count != 0 {
                        VStack(alignment: .leading, spacing: 0) {
                            ListSectionTitleView(text: "Son Harcamaların")
                            ExpenseListView(isDetailButtonActive: true)
                                .padding()
                        }
                    } else {
                        HStack {
                            Spacer()
                            Text("Şu ana kadar herhangi bir işlem eklemedin.")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 17, weight: .medium, design: .rounded))
                                .padding(50)
                            Spacer() 
                        }
                    }
                }
            }
            .background(Color(UIColor.systemGroupedBackground)
            .edgesIgnoringSafeArea(.all))
            .navigationBarTitle("Harcamaların")
            .navigationBarItems(
                leading:
                    Button(action: {
                        sheetNavigator.addExpenseViewIsPresented = false
                        sheetNavigator.dailyLimitViewIsPresented = true
                        showSheet = true
                    }) {
                       Image(systemName: "gearshape.fill")
                        .foregroundColor(.lightPurple)
                        .font(.system(size: 21))
                    },
                
                trailing:
                    Button(action: {
                        sheetNavigator.dailyLimitViewIsPresented = false
                        sheetNavigator.addExpenseViewIsPresented = true
                        showSheet = true
                    }) {
                       Image(systemName: "plus.circle.fill")
                        .foregroundColor(.lightPurple)
                        .font(.system(size: 21))
                    }
            )
        }
        .onAppear {
            if budgetManager.isFirstLaunch {
                sheetNavigator.dailyLimitViewIsPresented = true
                showSheet = true
            }
        }
        .sheet(isPresented: $showSheet, content: {
            getSheetView().presentation(isModal: budgetManager.$isFirstLaunch)
        })
    }
    
    // MARK: - Functions
    func getSheetView() -> AnyView {
        if sheetNavigator.addExpenseViewIsPresented {
            return AddExpenseView(showSheet: $showSheet).toAnyView()
        } else if sheetNavigator.dailyLimitViewIsPresented {
            return DailyLimitView(showSheet: $showSheet, expenseLimit: $expenseLimit).toAnyView()
        } else {
            return Text("Empty View").toAnyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExpenseView()
        }
    }
}
