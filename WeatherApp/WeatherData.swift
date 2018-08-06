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
    
    static let hoursAndMinutesFormat = DateFormatter(withFormat: "HH:mm", locale: Locale.current.description)
    
    private(set) var id = ""
    private(set) var city = ""
    private(set) var country = ""
    private(set) var temperature = ""
    private(set) var iconId = ""
    private(set) var windSpeed = ""
    private(set) var windDirection = WindDirection.N
    private(set) var weatherDescription = ""
    private(set) var moreDescription = ""
    private(set) var humidity = ""
    private(set) var clouds = ""
    private(set) var pressure = ""
    private(set) var lastUpdatedDate = Date()
    private(set) var sunrise = Date()
    private(set) var sunset = Date()
    let image = MutableProperty<UIImage>(UIImage())
        
    // MARK: - Mappable
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- (map["id"], DoubleToStringTransform())
        city <- map["name"]
        country <- map["sys.country"]
        clouds <- (map["clouds.all"], DoubleToStringTransform())
        temperature <- (map["main.temp"], DoubleToStringTransform())
        iconId <- map["weather.0.icon"]
        windSpeed <- (map["wind.speed"], DoubleToStringTransform())
        windDirection <- (map["wind.deg"], WindDirectionTransform())
        weatherDescription <- map["weather.0.main"]
        moreDescription <- map["weather.0.description"]
        humidity <- (map["main.humidity"], DoubleToStringTransform())
        lastUpdatedDate <- (map["dt"], DateAndTimeTranform())
        sunrise <- (map["sys.sunrise"], DateAndTimeTranform())
        sunset <- (map["sys.sunset"], DateAndTimeTranform())
        pressure <- (map["main.pressure"], DoubleToStringTransform())
        
        WeatherNetworker.downloadImage(for: iconId).startWithValues { [weak self] image in
            self?.image.value = image
        }
    }
}

enum WindDirection: String {
    case N, NNE, NE, ENE, E, ESE, SE, SSE, S, SSW, SW, WSW, W, WNW, NW, NNW
    
    private static let directions: [WindDirection] = [.N, .NNE, .NE, .ENE, .E, .ESE, .SE, .SSE, .S, .SSW, .SW, .WSW, .W, .WNW, .NW, .NNW]
    private static let sectionCount = 16
    private static let degreesInSection = 22.5
    private static let equalizer = 0.5
    
    init(_ deg: Double) {
        let val = Int(floor((deg / WindDirection.degreesInSection) + WindDirection.equalizer))
        self = WindDirection.directions[val % WindDirection.sectionCount];
    }
    
    func toDegrees() -> Double {
        return Double(WindDirection.directions.index(of: self)!) * WindDirection.degreesInSection
    }
}

fileprivate class DateAndTimeTranform: TransformType {
    typealias Object = Date
    
    typealias JSON = Double
    
    func transformFromJSON(_ value: Any?) -> DateAndTimeTranform.Object? {
        guard let value = value as? Double else {
            return nil
        }
        return Date(timeIntervalSince1970: value)
    }
    
    func transformToJSON(_ value: DateAndTimeTranform.Object?) -> DateAndTimeTranform.JSON? {
        guard let value = value else {
            return nil
        }
        return value.timeIntervalSince1970
    }
    
    
}

fileprivate class WindDirectionTransform: TransformType {
    typealias Object = WindDirection
    
    typealias JSON = Double
    
    func transformFromJSON(_ value: Any?) -> WindDirectionTransform.Object? {
        guard let value = value as? Double else {
            return nil
        }
        return WindDirection(value)
    }
    
    func transformToJSON(_ value: WindDirectionTransform.Object?) -> WindDirectionTransform.JSON? {
        guard let value = value else {
            return nil
        }
        return value.toDegrees()
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
