//
//  ButceWidget.swift
//  ButceWidget
//
//  Created by Can Balkaya on 10/13/20.
//

import WidgetKit
import SwiftUI

@main
struct CategoryWidget: Widget {
    
    // MARK: - Properties
    let kind: String = "ButceWidget"

    // MARK: - UI Elements
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            BudgetWidgetView(model: entry)
        }
        .configurationDisplayName("Günlük Harcamaların")
        .description("Hedefini tutturup tutturmadığına bak.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
