//
//  DarkSkyIconToImageTransform.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/10/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ObjectMapper

class DarkSkyIconToImageTransform: TransformType {
    typealias Object = UIImage
    typealias JSON = String
    
    private static let weatherIcons = [ "clear-day" : "01d",
                                        "clear-nght" : "01n",
                                        "rain" : "09d",
                                        "snow" : "13d",
                                        "sleet" : "13d",
                                        "wind" : "50d",
                                        "fog" : "50d",
                                        "cloudy" : "03d",
                                        "partly-cloudy-day" : "02d",
                                        "partly-cloudy-night" : "02n"]
    
    func transformFromJSON(_ value: Any?) -> DarkSkyIconToImageTransform.Object? {
        guard let icon = value as? String,
              let iconId = DarkSkyIconToImageTransform.weatherIcons[icon] else {
            return nil
        }
        return UIImage(named:  iconId)
    }
    
    func transformToJSON(_ value: DarkSkyIconToImageTransform.Object?) -> DarkSkyIconToImageTransform.JSON? {
        return nil
    }
    
    
}
