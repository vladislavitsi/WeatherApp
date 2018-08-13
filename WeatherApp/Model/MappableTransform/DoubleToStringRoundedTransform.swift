//
//  DoubleToStringTransform.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/08/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ObjectMapper

class DoubleToStringRoundedTransform: TransformType {
    typealias Object = String
    
    typealias JSON = Double
    
    func transformFromJSON(_ value: Any?) -> DoubleToStringRoundedTransform.Object? {
        guard let value = value as? Double else {
            return nil
        }
        return String(Int(round(value)))
    }
    
    func transformToJSON(_ value: DoubleToStringRoundedTransform.Object?) -> DoubleToStringRoundedTransform.JSON? {
        guard let value = value else {
            return nil
        }
        return Double(value)
    }
}
