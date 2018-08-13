//
//  WeekWeather.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/09/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import Foundation
import ObjectMapper

struct DayWeekWeather: Mappable {
    
    private(set) var highTemp = ""
    private(set) var lowTemp = ""
    private(set) var icon = UIImage()
    private(set) var time = Date()
    private(set) var weatherDescription = ""
    
    init() {
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        highTemp <- (map["temperatureHigh"], DoubleToStringRoundedTransform())
        lowTemp <- (map["temperatureLow"], DoubleToStringRoundedTransform())
        icon <- (map["icon"], DarkSkyIconToImageTransform())
        time <- (map["time"], UnixToDateTransform())
        weatherDescription <- map["summary"]
    }
    
}


