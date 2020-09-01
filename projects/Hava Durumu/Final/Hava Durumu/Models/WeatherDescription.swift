//
//  Weather.swift
//  Hava Durumu
//
//  Created by Ufuk Köşker on 11/08/2020.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit

struct WeatherDescription: Codable {
    
    // MARK: - Properties
    var iconName: String
    var description: String
    
    var icon: UIImage? {
        return UIImage(named: iconName)
    }
    
    enum CodingKeys: String, CodingKey {
        case iconName = "icon"
        case description = "description"
    }
}
