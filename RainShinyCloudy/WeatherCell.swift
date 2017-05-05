//
//  WeatherCell.swift
//  RainShinyCloudy
//
//  Created by Habibur Rahman on 5/5/17.
//  Copyright © 2017 Habibur Rahman. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherImageIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var hightempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
        
        func configureCell(forecast: Forecast){
            
            dayLabel.text = forecast.date
            weatherTypeLabel.text = forecast.weatherType
            weatherImageIcon.image = UIImage(named: forecast.weatherType)
            hightempLabel.text = forecast.highTemp
            lowTempLabel.text = forecast.lowTemp
        }
    
}
