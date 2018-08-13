//
//  PersistentDataProtocol.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/08/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

enum PersistentDataTypeWithData {
    case lat(Double)
    case lon(Double)
    case darkMode(Bool)
}

enum PersistentDataType: String {
    case darkMode
    case lat
    case lon
    
    var defaultValue: Any {
        switch self {
        case .darkMode:
            return false
        case .lat:
            return "51.5074"
        case .lon:
            return "0.1278"
        }
    }
}

protocol PersistentDataProtocol {    
    func setObject(for persistentType: PersistentDataTypeWithData)
    func getObject(for persistentType: PersistentDataType) -> Any
}
