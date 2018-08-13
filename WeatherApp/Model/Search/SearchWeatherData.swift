//
//  SearchWeatherData.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/07/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ObjectMapper
import ReactiveSwift

struct SearchWeatherData: Mappable {
    
    private(set) var lat = 0.0
    private(set) var lon = 0.0
    private(set) var city = ""
    private(set) var country = ""
    private(set) var weatherDescription = ""
    private(set) var temperature = ""
    private(set) var icon = UIImage()
    
    init() {
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        lat <- map["coord.lat"]
        lon <- map["coord.lon"]
        city <- map["name"]
        country <- map["sys.country"]
        weatherDescription <- map["weather.0.main"]
        temperature <- (map["main.temp"], DoubleToStringRoundedTransform())
        icon <- (map["weather.0.icon"], StringToImageTransform())
    }

}


