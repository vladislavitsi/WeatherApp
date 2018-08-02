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

class ViewController: UIViewController {

    @IBOutlet weak var weatherBackgroundView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    
    let currentWeatherData = MutableProperty<WeaterData>(WeaterData())
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
        return refreshControl
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.addSubview(refreshControl)
        weatherBackgroundView.layer.cornerRadius = 10.0
        refresh()
        cityName.reactive.text <~ currentWeatherData.signal.map { $0.city.value }
        temperature.reactive.text <~ currentWeatherData.signal.map { $0.temperature.value }
        currentWeatherData.signal.observeValues { [weak self] weatherData in
            weatherData.imageSignalProducer.value.startWithValues { image in
                self?.weatherImage.image = image
                }
        }
    }
    
    func refresh() {
        WeatherNetworker
            .loadDataReact(with: "https://api.openweathermap.org/data/2.5/weather?q=London,uk&units=metric&appid=9adc5a90fbbca24bbcef96af05b8b5e1")
            .startWithValues { weatherData in
                self.currentWeatherData.value = weatherData
        }
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refresh()
        refreshControl.endRefreshing()
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

