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
    
    private(set) var id = ""
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
        id <- (map["id"], DoubleToStringTransform())
        city <- map["name"]
        country <- map["sys.country"]
        weatherDescription <- map["weather.0.main"]
        temperature <- (map["main.temp"], DoubleToStringTransform())
        icon <- (map["weather.0.icon"], IconTransform())
    }

}


