//
//  DegreeToWindDirectionTransform.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/08/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ObjectMapper

class DegreeToWindDirectionTransform: TransformType {
    typealias Object = WindDirection
    
    typealias JSON = Double
    
    func transformFromJSON(_ value: Any?) -> DegreeToWindDirectionTransform.Object? {
        guard let value = value as? Double else {
            return nil
        }
        return WindDirection(value)
    }
    
    func transformToJSON(_ value: DegreeToWindDirectionTransform.Object?) -> DegreeToWindDirectionTransform.JSON? {
        guard let value = value else {
            return nil
        }
        return value.toDegrees()
    }
}
