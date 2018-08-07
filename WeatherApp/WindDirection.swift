//
//  WindDirection.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/07/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import Foundation


enum WindDirection: String {
    case N, NNE, NE, ENE, E, ESE, SE, SSE, S, SSW, SW, WSW, W, WNW, NW, NNW
    
    private static let directions: [WindDirection] = [.N, .NNE, .NE, .ENE, .E, .ESE, .SE, .SSE, .S, .SSW, .SW, .WSW, .W, .WNW, .NW, .NNW]
    private static let sectionCount = 16
    private static let degreesInSection = 22.5
    private static let equalizer = 0.5
    
    init(_ deg: Double) {
        let val = Int(floor((deg / WindDirection.degreesInSection) + WindDirection.equalizer))
        self = WindDirection.directions[val % WindDirection.sectionCount];
    }
    
    func toDegrees() -> Double {
        return Double(WindDirection.directions.index(of: self)!) * WindDirection.degreesInSection
    }
}
