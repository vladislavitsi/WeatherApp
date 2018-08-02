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
    
    private(set) var weatherDataCollection = MutableProperty<[WeaterData]>([WeaterData]())
 
    func mapping(map: Map) {
        weatherDataCollection.value <- map["list"]
    }
    
    init() {
        
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
}
