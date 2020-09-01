//
//  DailyViewController.swift
//  Hava Durumu
//
//  Created by Ufuk Köşker on 11/08/2020.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit
import MapKit

class DailyViewController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    
    @IBOutlet weak var maximumTemperatureLabel: UILabel!
    @IBOutlet weak var minimumTemperatureLabel: UILabel!
    
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var uvIndexLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    // MARK: - Functions
    func updateUI(with weather: Weather) {
        /// Son günün hava durumu verilerini barındıran bir sabit tanımlanır.
        guard let today = weather.data.first else { return }
        
        /// Günün hava durumu bilgileri Label elemanlarına atanır.
        dateLabel.text = DateConfiguration.convertDateToDayName(date: today.datetime, identifier: "d MMM, EEEE")
        temperatureLabel.text = "\(Int(today.temperature))º"
        weatherIconImageView.image = today.weatherDescription.icon
        cityNameLabel.text = weather.cityName
        weatherStatusLabel.text = today.weatherDescription.description
        maximumTemperatureLabel.text = "\(Int(today.maxTemperature))º"
        minimumTemperatureLabel.text = "\(Int(today.minTemperature))º"
        windDirectionLabel.text = today.windDirection
        uvIndexLabel.text = String(format: "%1.f", today.uvIndex)
        windSpeedLabel.text = "\(String(format: "%1.f", today.windSpeed)) km/s"
        humidityLabel.text = "%\(today.relativeHumidity)"
    }
}
