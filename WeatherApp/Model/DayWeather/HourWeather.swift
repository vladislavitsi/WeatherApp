//
//  HourWeather.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/07/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ObjectMapper

struct HourWeather: Mappable {
    
    private(set) var temperature = ""
    private(set) var icon = UIImage()
    private(set) var time = Date()
    
    init() {
    }
    
    init?(map: Map) {
        
    }

    mutating func mapping(map: Map) {
        temperature <- (map["main.temp"], DoubleToStringRoundedTransform())
        icon <- (map["weather.0.icon"], StringToImageTransform())
        time <- (map["dt"], UnixToDateTransform())
    }
    
    
}
