//
//  UnixToDateTransform.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/08/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ObjectMapper

class UnixToDateTransform: TransformType {
    typealias Object = Date
    
    typealias JSON = Double
    
    func transformFromJSON(_ value: Any?) -> UnixToDateTransform.Object? {
        guard let value = value as? Double else {
            return nil
        }
        return Date(timeIntervalSince1970: value)
    }
    
    func transformToJSON(_ value: UnixToDateTransform.Object?) -> UnixToDateTransform.JSON? {
        guard let value = value else {
            return nil
        }
        return value.timeIntervalSince1970
    }
}
