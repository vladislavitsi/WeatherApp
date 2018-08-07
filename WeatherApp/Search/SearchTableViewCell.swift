//
//  SearchTableViewCell.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/02/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class SearchTableViewCell: UITableViewCell {

    var i = 0
    
    @IBOutlet weak var cityAndCountry: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!

    let viewModel = MutableProperty(SearchWeatherData())
    
    func bindViewModel () {
        cityAndCountry.reactive.text <~ viewModel.signal.map { "\($0.city), \($0.country)" }
        weatherDescription.reactive.text <~ viewModel.signal.map { $0.weatherDescription }
        temperature.reactive.text <~ viewModel.signal.map { $0.temperature + "°" }
        imageIcon.reactive.image <~ viewModel.map { $0.icon }
    }
    override func didMoveToSuperview() {
        bindViewModel()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        cityAndCountry.text = ""
        weatherDescription.text = ""
        temperature.text = ""
        imageIcon.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
