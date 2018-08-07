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
    
    @IBOutlet weak var dayWeatherCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var searchPanel: UIView!
    @IBOutlet weak var locationWeatherButton: UIView!
    
    let currentWeatherCityId = MutableProperty("")
    
    private let currentWeatherData = MutableProperty(WeaterData())
    private let currentDayWeather = MutableProperty(DayWeather())
    private let locationManager = CLLocationManager()
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
        return refreshControl
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.addSubview(refreshControl)
        dayWeatherCollectionView.dataSource = self
//        dayWeatherCollectionView.delegate = self
        stack.arrangedSubviews.forEach { $0.layer.cornerRadius = 10.0 }
        
        city.reactive.text <~ currentWeatherData.map { $0.city+", "+$0.country }
        weatherDescription.reactive.text <~ currentWeatherData.signal.map { $0.moreDescription.capitalizingFirstLetter() }
        temperature.reactive.text <~ currentWeatherData.map { $0.temperature + "°" }
        weatherImage.reactive.image <~ currentWeatherData.map { $0.icon }
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
        
        currentWeatherCityId.signal
            .observeValues { [weak self] in
                UserDefaults.standard.set($0, forKey: "Location")
                self?.refresh()
        }
        
        currentDayWeather.signal.observeValues { [weak self] _ in
            self?.dayWeatherCollectionView.reloadData()
        }
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        currentWeatherCityId.value = UserDefaults.standard.object(forKey: "Location") as? String ?? "0"
    }
    
    func refresh() {
        WeatherNetworker
            .getData(for: .urlWithCityId, arguments: currentWeatherCityId.value)
            .startWithValues { [weak self] weatherData in
                self?.currentWeatherData.value = weatherData
        }
        WeatherNetworker
            .getData(for: .dayWeather, arguments: currentWeatherCityId.value)
            .startWithValues { [weak self] dayWeather in
                self?.currentDayWeather.value = dayWeather
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

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentDayWeather.value.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourWeatherCell", for: indexPath) as! HourWeatherCollectionViewCell
        let hourWeather = currentDayWeather.value.list[indexPath.row]
        cell.icon.image = hourWeather.icon
        cell.temperature.text = hourWeather.temperature + "°"
        cell.time.text = WeaterData.hoursAndMinutesFormat.string(from: hourWeather.time)
        return cell
    }
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coodinates = locations.first?.coordinate else {
            return
        }
        WeatherNetworker
            .getData(for: WeatherNetworker.RequestType.urlWithCoordinates, arguments: coodinates.latitude.description, coodinates.longitude.description)
            .startWithValues { [weak self] (weatherData: WeaterData) in
                self?.currentWeatherCityId.value = weatherData.id
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}

