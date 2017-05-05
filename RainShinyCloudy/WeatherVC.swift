//
//  WeatherVC.swift
//  RainShinyCloudy
//
//  Created by Habibur Rahman on 5/1/17.
//  Copyright © 2017 Habibur Rahman. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImgae: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetails {
            // update ui
            
            self.updateMainUI()
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func updateMainUI(){
        
        dateLabel.text = currentWeather.date
        temperatureLabel.text = "\(currentWeather.currentTemp)"
        cityLabel.text = currentWeather.cityName
        weatherLabel.text = currentWeather.weatherType
        weatherImgae.image = UIImage(named: currentWeather.weatherType)
        
        
    }
}

