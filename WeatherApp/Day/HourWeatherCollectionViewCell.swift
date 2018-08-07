//
//  HourWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/07/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class HourWeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var time: UILabel!

    override func prepareForReuse() {
        icon.image = nil
        temperature.text = ""
        time.text = ""
    }
}
