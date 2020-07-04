//
//  ReminderManager.swift
//  Hatirlatici
//
//  Created by Can Balkaya on 6/29/20.
//  Copyright © 2020 Can Balkaya. All rights reserved.
//

import Foundation

class ReminderManager {
    
    // MARK: - Properties
    private let dataSourceURL: URL
    private var allReminders: [ReminderItem] {
        get {
            do {
                let decoder = PropertyListDecoder()
                let data = try Data(contentsOf: dataSourceURL)
                let decodedReminders = try! decoder.decode([ReminderItem].self, from: data)
                
                return decodedReminders
            } catch {
                return []
            }
        }
        set {
            do {
                let encoder = PropertyListEncoder()
                let data = try encoder.encode(newValue)
                
                try data.write(to: dataSourceURL)
            } catch {
                
            }
        }
    }
    
    // MARK: - Life Cycle
    init() {

        // Bir projede birden çok döküman olabilir, ama bizim projemizde sadece bir tane döküman olduğundan o değeri tanımlayabilmek için "[0]" işaretini kullandık.
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let remindersPath = documentsPath.appendingPathComponent("reminders").appendingPathExtension("plist")
        
        dataSourceURL = remindersPath
    }
    
    // MARK: - Functions
    func getAllReminders() -> [ReminderItem] {
        return allReminders
    }
    
    func create(reminder: ReminderItem) {
        
        // Yeni oluşturduğumuz elemanı TableView elemanının en üstünde yerleştirmek için "insert" fonksiyonunu kullanıyoruz.
        allReminders.insert(reminder, at: 0)
        NotificationProvider.scheduleNotification(title: reminder.title, date: reminder.dueDate, id: reminder.id)
    }
    
    func setComplete(reminder: ReminderItem) {
        
        // Hangi hatırlatıcının tamamlandırıldığını bilmek için "index" değerini tanımlıyoruz.
        if let index = allReminders.firstIndex(where: { $0.id == reminder.id }) {
            allReminders[index].isCompleted.toggle()
        }
    }
    
    func delete(reminder: ReminderItem) {
        if let index = allReminders.firstIndex(where: { $0.id == reminder.id }) {
            allReminders.remove(at: index)
            NotificationProvider.cancelNotification(reminder.id)
        }
    }
}
