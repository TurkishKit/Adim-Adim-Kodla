//
//  WeatherContainerViewController.swift
//  Hava Durumu
//
//  Created by Can Balkaya on 8/24/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherPageViewController: UIPageViewController {
    
    enum Appearance: Int {
        case daily
        case weekly
    }
    
    // MARK: - UI Elements
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    lazy var dailyViewController: DailyViewController = {
        return storyboard!.instantiateViewController(identifier: "DailyViewController")
    }()
    
    lazy var weeklyViewController: WeeklyViewController = {
        return storyboard!.instantiateViewController(identifier: "WeeklyViewController")
    }()
    
    var managedControllers: [UIViewController] {
        return [dailyViewController, weeklyViewController]
    }
    
    // MARK: - Properties
    let locationManager = CLLocationManager()
    var currentAppearance: Appearance = .daily
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestLocation()
        
        updateCurrentController(animated: false)
    }
    
    // MARK: - Functions
    func updateCurrentController(animated: Bool) {
        switch currentAppearance {
        case .daily:
            setViewControllers([dailyViewController], direction: .reverse, animated: animated, completion: nil)
        case .weekly:
            setViewControllers([weeklyViewController], direction: .forward, animated: animated, completion: nil)
        }
    }
    
    // MARK: Actions
    @IBAction func segmentedControlValueChanged(_ segmentedControl: UISegmentedControl) {
        if let newAppearance = Appearance(rawValue: segmentedControl.selectedSegmentIndex) {
            currentAppearance = newAppearance
            updateCurrentController(animated: true)
        }
    }
}

extension WeatherPageViewController: CLLocationManagerDelegate {
    
    // MARK: - Functions
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Uygulamanın konum servislerini kullanma yetkisi yok.")
        case .denied:
            print("Kullanıcı, uygulama için konum servislerinin kullanımını reddetti veya Ayarlar'da genel olarak devre dışı bırakıldı.")
        case .authorizedAlways:
            print("Kullanıcı, istediği zaman konum hizmetini başlatması için uygulamaya izin verdi.")
        case .authorizedWhenInUse:
            print("Kullanıcı, uygulamadayken konum servislerini başlatmasına izi verdi.")
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let myCoordinate = locations.first?.coordinate {
            let weatherProvider = WeatherProvider()
            
            weatherProvider.getWeather(for: myCoordinate) { (weather) in
                guard let weather = weather else { return }
                
                self.dailyViewController.updateUI(with: weather)
                self.weeklyViewController.weather = weather
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
