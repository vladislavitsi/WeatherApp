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
    enum RequestType: String {
        case urlWithCityName = "https://api.openweathermap.org/data/2.5/weather?q=%@&units=metric&appid=9adc5a90fbbca24bbcef96af05b8b5e1"
        case urlWithCityId = "https://api.openweathermap.org/data/2.5/weather?id=%d&units=metric&appid=9adc5a90fbbca24bbcef96af05b8b5e1"
        case urlWithCoordinates = "https://api.openweathermap.org/data/2.5/weather?lat=%d&lon=%d&units=metric&appid=9adc5a90fbbca24bbcef96af05b8b5e1"
        case searchUrl = "https://api.openweathermap.org/data/2.5/find?q=%@&type=like&mode=json&units=metric&appid=9adc5a90fbbca24bbcef96af05b8b5e1"
    }
    
    static func searchData(with text: String) -> SignalProducer<SearchResult, NoError> {
        return SignalProducer<SearchResult, NoError> { sink, disposable in
            let url = String(format: RequestType.searchUrl.rawValue, text)
            Alamofire.request(url).responseObject { (response: DataResponse<SearchResult>) in
                guard let loadedResult = response.result.value else {
                    sink.sendCompleted()
                    return
                }
                sink.send(value: loadedResult)
                sink.sendCompleted()
            }
        }
    }
    
    
//    static func loadData(with url: String, requestType: RequestType) -> WeaterData {
//        let weatherData = WeaterData()
//        loadData(with: requestType.rawValue, requestType: requestType)
//    }
//
//    static func loadData(with url: String, weatherData: WeaterData) {
//        Alamofire.request(url).responseObject { (response: DataResponse<WeaterData>) in
//            guard let loadedWeatherData = response.result.value else {
//                return
//            }
//            weatherData.apply(from: loadedWeatherData)
//        }
//    }
//
    static func loadDataReact(with url: String) -> SignalProducer<WeaterData, NoError> {
        return SignalProducer<WeaterData, NoError> { sink, disposable in
            Alamofire.request(url).responseObject { (response: DataResponse<WeaterData>) in
                guard let loadedWeatherData = response.result.value else {
                    sink.sendCompleted()
                    return
                }
                sink.send(value: loadedWeatherData)
                sink.sendCompleted()
            }
        }
    }

    
    static func downloadImage(for iconId: String) -> SignalProducer<UIImage, NoError> {
        return SignalProducer<UIImage, NoError> { sink, disposable in
            // Alamofire image loader
            Alamofire.request("https://openweathermap.org/img/w/\(iconId).png").responseData { response in
                guard let data = response.result.value,
                    let image = UIImage(data: data) else {
                        sink.sendCompleted()
                        return
                }
                sink.send(value: image)
                sink.sendCompleted()
            }
        }
    }
}
