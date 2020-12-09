//
//  Date+Ext.swift
//  Butce
//
//  Created by Can Balkaya on 10/11/20.
//

import Foundation

extension Date {
    
    // MARK: - Functions
    func daysAdded(_ days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    func dayComponent() -> Int {
        return Calendar.current.component(.day, from: self)
    }

    func nextMonday() -> Date {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "tr")
        let components = calendar.dateComponents([.weekday], from: Date().daysAdded(7))
        let difference = components.weekday! - calendar.firstWeekday
        let nextMondayDate = Date().daysAdded(difference)
        
        return nextMondayDate
    }
}
