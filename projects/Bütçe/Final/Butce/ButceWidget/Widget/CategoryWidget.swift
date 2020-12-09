//
//  CategoryWidget.swift
//  CategoryWidget
//
//  Created by Can Balkaya on 10/13/20.
//

import WidgetKit
import SwiftUI

struct CategoryWidget: Widget {
    
    // MARK: - Properties
    let kind: String = "CategoryWidget"

    // MARK: - UI Elements
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CategoryWidgetView(model: entry)
        }
        .configurationDisplayName("Kategorilerin")
        .description("Bu hafta hangi kategorilerden ne kadar harcama yaptığına bak.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
