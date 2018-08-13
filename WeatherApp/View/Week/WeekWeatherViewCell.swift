//
//  WeekWeatherViewCell.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/09/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class WeekWeatherViewCell: UIView, DarkThemeSupport {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var day: UILabel!
    
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var weatherDescription: UILabel!
    
    let viewModel = MutableProperty(DayWeekWeather())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()

    }

    private func commonInit() {
        Bundle.main.loadNibNamed("WeekWeatherViewCell", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.layer.cornerRadius = 10
        
        day.reactive.text <~ viewModel.producer.map { $0.time.toWeekDayAndDateFormat() }
        highTemp.reactive.text <~ viewModel.producer.map { $0.highTemp + "°" }
        lowTemp.reactive.text <~ viewModel.producer.map { $0.lowTemp + "°" }
        icon.reactive.image <~ viewModel.producer.map { $0.icon }
        weatherDescription.reactive.text <~ viewModel.producer.map { $0.weatherDescription }
        
        contentView.reactive.backgroundColor <~ themeManager.isDarkModeProducer.map { ThemeManager.get(color: .accent, for: $0) }
        day.reactive.textColor <~ themeManager.isDarkModeProducer.map { ThemeManager.get(color: .text, for: $0) }
        lowTemp.reactive.textColor <~ themeManager.isDarkModeProducer.map { ThemeManager.get(color: .tint, for: $0) }
        highTemp.reactive.textColor <~ themeManager.isDarkModeProducer.map { ThemeManager.get(color: .text, for: $0) }
        weatherDescription.reactive.textColor <~ themeManager.isDarkModeProducer.map { ThemeManager.get(color: .tint, for: $0) }
        
    }
    
}
