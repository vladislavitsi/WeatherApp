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

class WeaterData: Mappable {
    
    private(set) var id = ""
    private(set) var city = ""
    private(set) var country = ""
    private(set) var temperature = ""
    private(set) var iconId = ""
    private(set) var windSpeed = ""
    private(set) var weatherDescription = ""
    let image = MutableProperty<UIImage>(UIImage())
        
    // MARK: - Mappable
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- (map["id"], DoubleToStringTransform())
        city <- map["name"]
        country <- map["sys.country"]
        temperature <- (map["main.temp"], DoubleToStringTransform())
        iconId <- map["weather.0.icon"]
        windSpeed <- (map["wind.speed"], DoubleToStringTransform())
        weatherDescription <- map["weather.0.main"]
        
        WeatherNetworker.downloadImage(for: iconId).startWithValues { [weak self] image in
            self?.image.value = image
        }
    }
}

fileprivate class DoubleToStringTransform: TransformType {
    typealias Object = String
    
    typealias JSON = Double
    
    func transformFromJSON(_ value: Any?) -> DoubleToStringTransform.Object? {
        guard let value = value as? Double else {
            return nil
        }
        return String(Int(value))
    }
    
    func transformToJSON(_ value: DoubleToStringTransform.Object?) -> DoubleToStringTransform.JSON? {
        guard let value = value else {
            return nil
        }
        return Double(value)
    }
    
    
}
