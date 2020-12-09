//
//  ButceApp.swift
//  Butce
//
//  Created by Sergen Gonenc on 10/8/20.
//

import SwiftUI

@main
struct ButceApp: App {
    
    // MARK: - Properties
    @StateObject var budgetManager = BudgetManager.shared
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ExpenseView()
                    .tabItem {
                        Image(systemName: "wallet.pass.fill")
                        Text("Harcamaların")
                    }
                    .tag(0)
                
                StatisticsView()
                    .tabItem {
                        Image(systemName: "chart.bar.fill")
                        Text("İstatistikler")
                    }
                    .tag(1)
            }
            .accentColor(.lightPurple)
            .environmentObject(budgetManager)
        }
    }
}
