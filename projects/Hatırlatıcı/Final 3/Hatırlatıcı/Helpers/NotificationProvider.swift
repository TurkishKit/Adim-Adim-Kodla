//
//  NotificationProvider.swift
//  Hatırlatıcı
//
//  Created by Can Balkaya on 6/30/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit

class NotificationProvider {
    static func scheduleNotification(title: String, date: Date, id: String) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                createNotification(title: title, date: date, id: id)
            } else {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, _ in
                    if success {
                        createNotification(title: title, date: date, id: id)
                    }
                }
            }
        }
    }
    
    static func cancelNotification(_ identifiers: String) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [identifiers])
    }
    
    static func createNotification(title: String, date: Date, id: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: date.timeIntervalSinceNow, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
