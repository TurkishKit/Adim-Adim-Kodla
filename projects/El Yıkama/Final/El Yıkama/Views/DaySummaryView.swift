//
//  DaySummaryView.swift
//  El Yıkama
//
//  Created by Can Balkaya on 5/20/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import SwiftUI

struct DaySummaryView: View {
    
    // MARK: - Enumerations
    enum DateType: String {
        case yesterday = "Dün"
        case today = "Bugün"
        
        func date() -> Date {
            switch self {
            case .yesterday:
                var dateComponents = DateComponents()
                dateComponents.setValue(-1, for: .day)
                
                return Calendar.current.date(byAdding: dateComponents, to: Date())!
            case .today:
                return Date()
            }
        }
    }
    
    // MARK: - Properties
    let viewType: DateType
    @Binding var handWashCount: Int
    
    // MARK: - UI Elements
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(dateString())
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .opacity(0.7)
                
                Text(viewType.rawValue)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .opacity(0.85)
            }
            
            Spacer()
            
            Text("\(handWashCount)")
                .font(.system(size: 36, weight: .bold, design: .rounded))
        }
        .padding(EdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15))
        .foregroundColor(textColor())
        .background(backgroundColor())
        .cornerRadius(10)
    }
    
    // MARK: - Functions
    func dateString() -> String {
        let date = viewType.date()
        let dayDateFormatter = DateFormatter()
        dayDateFormatter.dateFormat = "d MMMM"
        dayDateFormatter.locale = Locale(identifier: "tr")
        
        return dayDateFormatter.string(from: date)
    }
    
    func textColor() -> Color {
        return viewType == .today ? .white : .black
    }
    
    func backgroundColor() -> Color {
        return viewType == .today ? .darkBlue : .white
    }
}
