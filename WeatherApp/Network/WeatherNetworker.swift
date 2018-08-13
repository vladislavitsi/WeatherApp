//
//  Networker.swift
//  nasa-api
//
//  Created by Uladzislau Kleshchanka on Aug/01/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import ReactiveSwift
import Result

class WeatherNetworker {
    
    private static let myappid = "9adc5a90fbbca24bbcef96af05b8b5e1"
    
    enum RequestType: String {
        case urlWithCityName = "https://api.openweathermap.org/data/2.5/weather?q=%@&units=metric&appid=9adc5a90fbbca24bbcef96af05b8b5e1"
        case urlWithCoordinates = "https://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&units=metric&appid=9adc5a90fbbca24bbcef96af05b8b5e1"
        case searchUrl = "https://api.openweathermap.org/data/2.5/find?q=%@&type=like&mode=json&units=metric&appid=9adc5a90fbbca24bbcef96af05b8b5e1"
        case oneDayWeather = "https://api.openweathermap.org/data/2.5/forecast?lat=%@&lon=%@&mode=json&units=metric&cnt=9&appid=9adc5a90fbbca24bbcef96af05b8b5e1"
        case dailyWeather = "https://api.darksky.net/forecast/561b34ea09e06ec1816a461036298a1d/%@,%@?exclude=currently,minutely,hourly,alerts,flags&units=si"
    }
    
    static func getData<T: Mappable>(for requestType: RequestType, arguments argument1: Double, _ argument2: Double) -> SignalProducer<T, NoError> {
        return getData(for: requestType, arguments: String(argument1), String(argument2))
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

}

