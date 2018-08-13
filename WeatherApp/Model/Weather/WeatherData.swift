//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/02/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import ObjectMapper

struct WeatherData: Mappable {
    
    private(set) var lat = 0.0
    private(set) var lon = 0.0
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
        lat <- map["coord.lat"]
        lon <- map["coord.lon"]
        city <- map["name"]
        country <- map["sys.country"]
        clouds <- (map["clouds.all"], DoubleToStringRoundedTransform())
        temperature <- (map["main.temp"], DoubleToStringRoundedTransform())
        windSpeed <- (map["wind.speed"], DoubleToStringRoundedTransform())
        windDirection <- (map["wind.deg"], DegreeToWindDirectionTransform())
        weatherDescription <- map["weather.0.main"]
        moreDescription <- map["weather.0.description"]
        humidity <- (map["main.humidity"], DoubleToStringRoundedTransform())
        lastUpdatedDate <- (map["dt"], UnixToDateTransform())
        sunrise <- (map["sys.sunrise"], UnixToDateTransform())
        sunset <- (map["sys.sunset"], UnixToDateTransform())
        pressure <- (map["main.pressure"], DoubleToStringRoundedTransform())
        icon <- (map["weather.0.icon"], StringToImageTransform())
    }
}
