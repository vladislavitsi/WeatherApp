//
//  StringToImageTransform.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/08/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ObjectMapper

class StringToImageTransform: TransformType {
    typealias Object = UIImage
    
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> StringToImageTransform.Object? {
        guard let iconId = value as? String else {
            return nil
        }
        return UIImage(named: iconId)
    }
    
    func transformToJSON(_ value: StringToImageTransform.Object?) -> StringToImageTransform.JSON? {
        return nil
    }
}
