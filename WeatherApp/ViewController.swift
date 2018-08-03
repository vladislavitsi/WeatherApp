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

    
    let transition = SearchViewAnimator()
    
    @IBOutlet weak var weatherBackgroundView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    
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
        
        
        weatherBackgroundView.layer.cornerRadius = 10.0
//        weatherBackgroundView.layer.shadowRadius = 3.0
//        weatherBackgroundView.layer.masksToBounds = false
//        weatherBackgroundView.layer.shadowColor = UIColor.black.cgColor
//        weatherBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        weatherBackgroundView.layer.shadowOpacity = 0.2
//        weatherBackgroundView.layer.shadowPath = UIBezierPath(rect: weatherBackgroundView.bounds).cgPath

        
        locationWeatherButton.layer.cornerRadius = 10.0
        
        cityName.reactive.text <~ currentWeatherData.signal.map { $0.city }
        temperature.reactive.text <~ currentWeatherData.signal.map { $0.temperature }
        weatherImage.reactive.image <~ currentWeatherData.map { $0.image }.flatten(FlattenStrategy.latest)
        
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
        searchVC.transitioningDelegate = self
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

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.originFrame = searchPanel.frame
        
        transition.presenting = true
        
        return transition
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        transition.originFrame = searchPanel.frame
        
        transition.presenting = true
        
        return transition

    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        transition.presenting = false
        return transition
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}


