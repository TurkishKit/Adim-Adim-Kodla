//
//  Category.swift
//  Butce
//
//  Created by Sergen Gonenc on 10/8/20.
//

import SwiftUI

struct Category: Codable {
    
    // MARK: - Properties
    var id = UUID()
    let name: String
    let icon: String
    
    static let shopping = Category(name: "Alışveriş", icon: "👚")
    static let food = Category(name: "Yiyecek", icon: "🍕")
    static let travel = Category(name: "Seyahat", icon: "🚘")
    static let healthcare = Category(name: "Sağlık", icon: "💊")
    static let tech = Category(name: "Teknoloji", icon: "🖥")
    static let entertainment = Category(name: "Eğlence", icon: "🎮")
    static let sports = Category(name: "Spor", icon: "🏓")
    static let education = Category(name: "Eğitim", icon: "📚")
    static let hospitality = Category(name: "Konaklama", icon: "🏠")
    
    static var all: [Category] {
        return [.shopping, .food, .travel, .healthcare, .tech, .entertainment, .sports, .education, .hospitality]
    }
}
