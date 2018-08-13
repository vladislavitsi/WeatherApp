//
//  DateExtension.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/10/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import Foundation

extension Date {
    private static let hoursAndMinutesFormat = DateFormatter(withFormat: "HH:mm", locale: Locale.current.description)
    
    private static let weekDayAndDateFormat = DateFormatter(withFormat: "EEEE, dd MMM", locale: Locale.current.description)
    
    func toHoursAndMinutesFormat() -> String {
        return Date.hoursAndMinutesFormat.string(from: self)
    }
    
    func toWeekDayAndDateFormat() -> String {
        return Date.weekDayAndDateFormat.string(from: self)
    }
}
