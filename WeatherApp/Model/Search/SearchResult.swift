//
//  SearchResult.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/02/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import Foundation
import ReactiveSwift
import ObjectMapper

class SearchResult: Mappable {
    
    private(set) var weatherDataCollection = MutableProperty<[SearchWeatherData]>([SearchWeatherData]())
 
    func mapping(map: Map) {
        weatherDataCollection.value <- map["list"]
    }

    required convenience init?(map: Map) {
        self.init()
    }
}
