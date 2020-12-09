//
//  ExpenceWidget.swift
//  Butce
//
//  Created by Can Balkaya on 11/1/20.
//

import SwiftUI
import WidgetKit

struct ExpenseWidget: Widget {
    
    // MARK: - Properties
    let kind: String = "ExpenseWidget"

    // MARK: - UI Elements
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ExpenseWidgetView(model: entry)
        }
        .configurationDisplayName("Harcamaların")
        .description("Son harcamalarını gör.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
