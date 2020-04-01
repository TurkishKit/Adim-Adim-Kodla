//
//  DataStore.swift
//  Water Tracker
//
//  Created by Can Balkaya on 3/27/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import Foundation

class DataStore {
    
    // MARK: - Properties
    let defaults = UserDefaults.standard
    
    var currentDay: Int {
        let now = Date()
        let day = Calendar.current.component(.day, from: now)
        
        return day
    }
    
    // MARK: - Life Cycle
    init() {
        let latestUpdateDay = getLatestUpdateDay()

        if latestUpdateDay != currentDay {
            defaults.set(0, forKey: "currentAmount")
        }
    }
    
    // MARK: - Functions
    func getCurrentAmount() -> Double {
        let savedAmount = defaults.double(forKey: "currentAmount")
        return savedAmount
    }
    
    func getLatestUpdateDay() -> Int {
        let latestUpdateDay = defaults.integer(forKey: "latestUpdateDay")
        return latestUpdateDay
    }
    
    func addWater(amount: Double) {
        let currentAmount = getCurrentAmount()
        let newAmount = currentAmount + amount
        
        defaults.set(newAmount, forKey: "currentAmount")
        defaults.set(currentDay, forKey: "latestUpdateDay")
    }
}
