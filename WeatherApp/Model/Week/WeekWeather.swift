//
//  WeekWeather.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/09/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import Foundation
import ObjectMapper
import ReactiveSwift

struct WeekWeather: Mappable {
    
    private(set) var list = [DayWeekWeather]()
    
    init() {
    }
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        list <- map["daily.data"]
    }
}
