//
//  PersistentDataProtocol.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/08/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import Foundation

enum PersistentDataTypeWithData {
    case location(String)
    case darkMode(Bool)
}

enum PersistentDataType: String {
    case location
    case darkMode
    
    var defaultValue: Any {
        switch self {
        case .location:
            return "2643743"
        case .darkMode:
            return false
        }
    }
}

protocol PersistentDataProtocol {
    func setObject(for persistentType: PersistentDataTypeWithData)
    func getObject(for persistentType: PersistentDataType) -> Any
}
