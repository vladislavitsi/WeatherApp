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
    
    let id = MutableProperty<String>("")
    let city = MutableProperty<String>("")
    let country = MutableProperty<String>("")
    let temperature = MutableProperty<String>("")
    let iconId = MutableProperty<String>("")
    let windSpeed = MutableProperty<String>("")
    let weatherDescription = MutableProperty<String>("")
    
    var imageSignalProducer = MutableProperty(SignalProducer<UIImage, NoError> { sink, disposable in sink.sendCompleted()})
    
    func apply(from other: WeaterData) {
        self.city.value = other.city.value
        self.country.value = other.country.value
        self.temperature.value = other.temperature.value
        self.iconId.value = other.iconId.value
        self.id.value = other.id.value
        self.weatherDescription.value = other.weatherDescription.value
    }
    
    
    // MARK: - Initializers
    
    init() {
        iconId.signal
            .observeValues { [weak self] iconId in
                self?.imageSignalProducer.value = WeatherNetworker.downloadImage(for: iconId)
            }
    }
    
    convenience init(city: String, temperature: String, iconId: String) {
        self.init()
        self.city.value = city
        self.temperature.value = temperature
        self.iconId.value = iconId
    }
    
    
    // MARK: - Mappable
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id.value <- (map["id"], DoubleToStringTransform())
        city.value <- map["name"]
        country.value <- map["sys.country"]
        temperature.value <- (map["main.temp"], DoubleToStringTransform())
        iconId.value <- map["weather.0.icon"]
        windSpeed.value <- (map["wind.speed"], DoubleToStringTransform())
        weatherDescription.value <- map["weather.0.main"]
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
