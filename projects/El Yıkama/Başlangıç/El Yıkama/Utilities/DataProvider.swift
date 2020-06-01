//
//  DataProvider.swift
//  El Yıkama
//
//  Created by Can Balkaya on 5/20/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import SwiftUI

class DataProvider {
    
    // MARK: - Properties
    let userDefaults = UserDefaults.standard
    static let shared = DataProvider()
    
    var todaysHandWashCount: Int {
        get { userDefaults.integer(forKey: #function) }
        set { userDefaults.set(newValue, forKey: #function) }
    }
    
    var yesterdaysHandWashCount: Int {
        get { userDefaults.integer(forKey: #function) }
        set { userDefaults.set(newValue, forKey: #function) }
    }
    
    var latestUpdateDay: Int {
        get { userDefaults.integer(forKey: #function) }
        set { userDefaults.set(newValue, forKey: #function) }
    }
    
    var advices: [Advice] {
        loadJSON(for: #function)
    }
    
    var handWashSteps: [HandWashStep] {
        loadJSON(for: #function)
    }
    
    private var currentDay: Int {
        let today = Date()
        let day = Calendar.current.component(.day, from: today)
        
        return day
    }
    
    // MARK: - Life Cycle
    fileprivate init() {
        if latestUpdateDay != currentDay {
            yesterdaysHandWashCount = todaysHandWashCount
            todaysHandWashCount = 0
        }
        
        latestUpdateDay = currentDay
    }
    
    // MARK: - Functions
    func increaseHandWashCount(_ counter: Int) {
        todaysHandWashCount = counter
        latestUpdateDay = currentDay
    }
    
    private func loadJSON<T: Codable>(for resource: String) -> [T] {
        let jsonFile =  Bundle.main.path(forResource: resource, ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile!), options: [])
        
        do {
            return try JSONDecoder().decode([T].self, from: data!)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}

let dataStore = DataProvider.shared
