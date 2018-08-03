//
//  Networker.swift
//  nasa-api
//
//  Created by Uladzislau Kleshchanka on Aug/01/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import ObjectMapper
import AlamofireObjectMapper
import ReactiveSwift
import Result

class WeatherNetworker {
    enum RequestType: String {
        case urlWithCityName = "https://api.openweathermap.org/data/2.5/weather?q=%@&units=metric&appid=9adc5a90fbbca24bbcef96af05b8b5e1"
        case urlWithCityId = "https://api.openweathermap.org/data/2.5/weather?id=%@&units=metric&appid=9adc5a90fbbca24bbcef96af05b8b5e1"
        case urlWithCoordinates = "https://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&units=metric&appid=9adc5a90fbbca24bbcef96af05b8b5e1"
        case searchUrl = "https://api.openweathermap.org/data/2.5/find?q=%@&type=like&mode=json&units=metric&appid=9adc5a90fbbca24bbcef96af05b8b5e1"
    }
    
    static func getData<T: Mappable>(for requestType: RequestType, arguments argument1: String, _ argument2: String = "" ) -> SignalProducer<T, NoError> {
        return SignalProducer<T, NoError> { sink, disposable in
            let url = String(format: requestType.rawValue, argument1, argument2)
            Alamofire.request(url).responseObject { (response: DataResponse<T>) -> Void in
                guard let loadedResult = response.result.value else {
                    sink.sendCompleted()
                    return
                }
                sink.send(value: loadedResult)
                sink.sendCompleted()
            }
        }
    }
    
    static func downloadImage(for iconId: String) -> SignalProducer<UIImage, NoError> {
        return SignalProducer<UIImage, NoError> { sink, disposable in
            // Alamofire image loader
            Alamofire.request("https://openweathermap.org/img/w/\(iconId).png").responseImage { response in
                guard let image = response.result.value else {
                    sink.sendCompleted()
                    return
                }
                sink.send(value: image)
                sink.sendCompleted()
            }
        }
    }

}
