//
//  HomePageView.swift
//  Butce
//
//  Created by Sergen Gonenc on 10/8/20.
//

import SwiftUI

struct ExpenseView: View {
    
    // MARK: - Properties
    @ObservedObject var sheetNavigator = SheetNavigator()
    @State var expenseLimit = DataProvider.shared.expenseLimit
    @State var dailySpent = DataProvider.shared.dailySpent
    @State var activities: [Activity] = ActivityProvider.shared.activities
    
    // MARK: - UI Elements
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 40) {
                    BudgetInfoView(expenseLimit: $expenseLimit, dailySpent: $dailySpent)
                        .padding(.top, 25)
            
                    if activities.count != 0 {
                        VStack(alignment: .leading, spacing: 0) {
                            ListSectionTitleView(text: "Son Hareketler")
                            ExpenseListView(activities: $activities, isDetailButtonActive: true)
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
            .navigationBarTitle("Ana Sayfa")
            .navigationBarItems(
                leading:
                    Button(action: {
                        sheetNavigator.addExpenseViewIsPresented = false
                        sheetNavigator.dailyLimitViewIsPresented = true
                        sheetNavigator.showSheet = true
                    }) {
                       Image(systemName: "gearshape")
                        .foregroundColor(.lightPurple)
                        .font(.system(size: 21))
                    },
                
                trailing:
                    Button(action: {
                        sheetNavigator.dailyLimitViewIsPresented = false
                        sheetNavigator.addExpenseViewIsPresented = true
                        sheetNavigator.showSheet = true
                    }) {
                       Image(systemName: "plus.circle.fill")
                        .foregroundColor(.lightPurple)
                        .font(.system(size: 21))
                    }
            )
        }
        .onAppear {
            expenseLimit = DataProvider.shared.expenseLimit
            dailySpent = DataProvider.shared.dailySpent
            activities = ActivityProvider.shared.activities
            
            if DataProvider.shared.isNewUser {
                sheetNavigator.dailyLimitViewIsPresented = true
                sheetNavigator.showSheet = true
            }
        }
        .sheet(isPresented: $sheetNavigator.showSheet, content: {
            getSheetView()
        })
    }
    
    // MARK: - Functions
    func getSheetView() -> AnyView {
        if sheetNavigator.addExpenseViewIsPresented {
            return AddExpenseView().eraseToAnyView()
        } else if sheetNavigator.dailyLimitViewIsPresented {
            return DailyLimitView(expenceLimit: $expenseLimit).eraseToAnyView()
        } else {
            return Text("Empty").eraseToAnyView()
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
