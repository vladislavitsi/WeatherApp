//
//  ViewController.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/01/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import AlamofireImage
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var weatherBackgroundView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var windDirection: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var clouds: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var lastUpdatedTime: UILabel!
    
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var searchPanel: UIView!
    let currentWeatherData = MutableProperty<WeaterData>(WeaterData())
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var locationWeatherButton: UIView!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
        return refreshControl
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.addSubview(refreshControl)
        
        stack.arrangedSubviews.forEach { $0.layer.cornerRadius = 10.0 }
        
        city.reactive.text <~ currentWeatherData.map { $0.city+", "+$0.country }
        weatherDescription.reactive.text <~ currentWeatherData.signal.map { $0.moreDescription.capitalizingFirstLetter() }
        temperature.reactive.text <~ currentWeatherData.map { $0.temperature + "°" }
        weatherImage.reactive.image <~ currentWeatherData.map { $0.image }.flatten(FlattenStrategy.latest)
        windSpeed.reactive.text <~ currentWeatherData.map { $0.windSpeed + " m/s" }
        windDirection.reactive.text <~ currentWeatherData.map { $0.windDirection.rawValue }
        humidity.reactive.text <~ currentWeatherData.map { $0.humidity + "%" }
        sunrise.reactive.text <~ currentWeatherData.map { WeaterData.hoursAndMinutesFormat.string(from: $0.sunrise) }
        sunset.reactive.text <~ currentWeatherData.map { WeaterData.hoursAndMinutesFormat.string(from: $0.sunset) }
        pressure.reactive.text <~ currentWeatherData.map { $0.pressure + " hPa" }
        lastUpdatedTime.reactive.text <~ currentWeatherData.map { "Last updated at "+WeaterData.hoursAndMinutesFormat.string(from: $0.lastUpdatedDate) }
        clouds.reactive.text <~ currentWeatherData.map { $0.clouds + " %" }
        
        searchPanel.layer.shadowRadius = 4.0
        searchPanel.layer.masksToBounds = false
        searchPanel.layer.shadowColor = UIColor.black.cgColor
        searchPanel.layer.shadowOffset = CGSize(width: 0, height: 2)
        searchPanel.layer.shadowOpacity = 0.2
        
        currentWeatherData.signal
            .map { $0.id }
            .observeValues { UserDefaults.standard.set($0, forKey: "location") }
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        refresh()
    }
    
    func refresh() {
        WeatherNetworker
            .getData(for: .urlWithCityId, arguments: UserDefaults.standard.object(forKey: "location") as! String)
            .startWithValues { weatherData in
                self.currentWeatherData.value = weatherData
        }
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refresh()
        refreshControl.endRefreshing()
    }
    
    @IBAction func currentLocationWeather(_ sender: UITapGestureRecognizer) {
        locationManager.requestLocation()

    }
    // MARK: - Navigation
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let searchVC = segue.destination as? SearchViewController else {
            return
        }
        searchVC.parentVC = self
    }
 
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coodinates = locations.first?.coordinate else {
            return
        }
        WeatherNetworker
            .getData(for: WeatherNetworker.RequestType.urlWithCoordinates, arguments: coodinates.latitude.description, coodinates.longitude.description)
            .startWithValues { (weatherData: WeaterData) in
                self.currentWeatherData.value = weatherData
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        WeatherNetworker
//            .getData(for: WeatherNetworker.RequestType.urlWithCityName, arguments: "London,UK")
//            .startWithValues { weatherData in
//                self.currentWeatherData.value = weatherData
//        }
    }
}

