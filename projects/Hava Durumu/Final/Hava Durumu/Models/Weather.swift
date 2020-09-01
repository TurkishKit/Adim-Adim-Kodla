//
//  WeatherRoot.swift
//  Hava Durumu
//
//  Created by Can Balkaya on 8/19/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import Foundation

struct Weather: Codable {
    
    // MARK: - Properties
    var cityName: String
    var data: [DailyWeather]
    
    // MARK: - Enumerations
    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case data = "data"
    }
}
