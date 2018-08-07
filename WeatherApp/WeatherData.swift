//
//  CurrentWeatherData.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/02/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import ObjectMapper

struct WeaterData: Mappable {
    
    static let hoursAndMinutesFormat = DateFormatter(withFormat: "HH:mm", locale: Locale.current.description)
    
    private(set) var id = ""
    private(set) var city = ""
    private(set) var country = ""
    private(set) var temperature = ""
    private(set) var windSpeed = ""
    private(set) var windDirection = WindDirection.N
    private(set) var weatherDescription = ""
    private(set) var moreDescription = ""
    private(set) var humidity = ""
    private(set) var clouds = ""
    private(set) var pressure = ""
    private(set) var lastUpdatedDate = Date()
    private(set) var sunrise = Date()
    private(set) var sunset = Date()
    private(set) var icon = UIImage()
    
    init() {}
    
    // MARK: - Mappable
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- (map["id"], DoubleToStringTransform())
        city <- map["name"]
        country <- map["sys.country"]
        clouds <- (map["clouds.all"], DoubleToStringTransform())
        temperature <- (map["main.temp"], DoubleToStringTransform())
        windSpeed <- (map["wind.speed"], DoubleToStringTransform())
        windDirection <- (map["wind.deg"], WindDirectionTransform())
        weatherDescription <- map["weather.0.main"]
        moreDescription <- map["weather.0.description"]
        humidity <- (map["main.humidity"], DoubleToStringTransform())
        lastUpdatedDate <- (map["dt"], DateAndTimeTranform())
        sunrise <- (map["sys.sunrise"], DateAndTimeTranform())
        sunset <- (map["sys.sunset"], DateAndTimeTranform())
        pressure <- (map["main.pressure"], DoubleToStringTransform())
        icon <- (map["weather.0.icon"], IconTransform())
    }
}
