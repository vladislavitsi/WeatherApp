//
//  MappableTransforms.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/07/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ObjectMapper

class IconTransform: TransformType {
    typealias Object = UIImage
    
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> IconTransform.Object? {
        guard let iconId = value as? String else {
            return nil
        }
        return UIImage(named: iconId)
    }
    
    func transformToJSON(_ value: IconTransform.Object?) -> IconTransform.JSON? {
        return nil
    }
}

class DateAndTimeTranform: TransformType {
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

class WindDirectionTransform: TransformType {
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

class DoubleToStringTransform: TransformType {
    typealias Object = String
    
    typealias JSON = Double
    
    func transformFromJSON(_ value: Any?) -> DoubleToStringTransform.Object? {
        guard let value = value as? Double else {
            return nil
        }
        return String(Int(round(value)))
    }
    
    func transformToJSON(_ value: DoubleToStringTransform.Object?) -> DoubleToStringTransform.JSON? {
        guard let value = value else {
            return nil
        }
        return Double(value)
    }
    
    
}
