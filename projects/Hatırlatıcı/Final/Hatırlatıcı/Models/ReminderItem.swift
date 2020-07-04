//
//  Reminder.swift
//  Hatırlatıcı
//
//  Created by Sergen Gonenc on 6/21/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import Foundation

struct ReminderItem: Codable {
    
    // MARK: - Properties
    var id = UUID().uuidString
    var title: String
    var dueDate: Date
    var isCompleted = false
}
