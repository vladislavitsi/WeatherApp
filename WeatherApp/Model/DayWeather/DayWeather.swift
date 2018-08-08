//
//  DayWeather.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/07/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import Foundation
import ObjectMapper

struct DayWeather: Mappable {
    
    private(set) var list = [HourWeather]()
    
    init() {}
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
//        id <- (map["city.id"], DoubleToStringTransform())
//        city <- map["city.name"]
//        country <- map["city.country"]
        list <- map["list"]
    }
}
