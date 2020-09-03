//
//  WeatherData.swift
//  Hava Durumu
//
//  Created by Can Balkaya on 8/19/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit

struct DailyWeather: Codable {
    
    // MARK: - Properties
    var maxTemperature: Double
    var minTemperature: Double
    var datetime: String
    var temperature: Double
    var uvIndex: Double
    var windDirection: String
    var windSpeed: Double
    var relativeHumidity: Int
    var chanceOfSnow: Double
    var cloudCoverage: Int
    var weatherDescription: WeatherDescription
    
    enum CodingKeys: String, CodingKey {
        case maxTemperature = "max_temp"
        case minTemperature = "min_temp"
        case datetime = "datetime"
        case temperature = "temp"
        case uvIndex = "uv"
        case windDirection = "wind_cdir"
        case windSpeed = "wind_spd"
        case relativeHumidity = "rh"
        case chanceOfSnow = "snow"
        case cloudCoverage = "clouds"
        case weatherDescription = "weather"
    }
}
