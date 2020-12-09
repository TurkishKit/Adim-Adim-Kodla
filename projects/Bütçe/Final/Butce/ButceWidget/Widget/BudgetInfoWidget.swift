//
//  BudgetInfoWidget.swift
//  Butce
//
//  Created by Can Balkaya on 11/1/20.
//

import SwiftUI
import WidgetKit

struct BudgetInfoWidget: Widget {
    
    // MARK: - Properties
    let kind: String = "BudgetInfoWidget"

    // MARK: - UI Elements
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            BudgetInfoWidgetView(model: entry)
        }
        .configurationDisplayName("Günlük Harcaman")
        .description("Bugün ne kadar harcama yaptığını gör.")
        .supportedFamilies([.systemSmall])
    }
}
