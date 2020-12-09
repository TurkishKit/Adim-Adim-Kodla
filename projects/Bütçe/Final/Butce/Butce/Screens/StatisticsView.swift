//
//  StatisticsView.swift
//  Butce
//
//  Created by Can Balkaya on 10/10/20.
//

import SwiftUI

struct StatisticsView: View {
    
    // MARK: - Properties
    @EnvironmentObject var budgetManager: BudgetManager
    let categories = Category.all
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    // MARK: - UI Elements
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    VStack(alignment: .leading, spacing: 0) {
                        ListSectionTitleView(text: "Haftalık Harcama")
                        ChartView()
                            .padding()
                    }
                    .padding(.top, 25)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        ListSectionTitleView(text: "Harcama Analizi")
                        LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                            ForEach(categories.indices, id: \.self) { index in
                                CategoryItemView(category: categories[index], amount: budgetManager.categoryAmounts[index])
                            }
                        }
                        .padding()
                    }
                }
            }
            .background(Color(UIColor.systemGroupedBackground)
            .edgesIgnoringSafeArea(.all))
            .navigationBarTitle("İstatistikler")
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
