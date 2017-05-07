//
//  WeatherVC.swift
//  RainShinyCloudy
//
//  Created by Habibur Rahman on 5/1/17.
//  Copyright © 2017 Habibur Rahman. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate{

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImgae: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var currentWeather: CurrentWeather!
    var forecasts = [Forecast]()
    var forecast: Forecast!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getUserLocation()
        
    }
    func getUserLocation(){
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            currentLocation = locationManager.location
            
            Location.shareInstance.latitude = currentLocation.coordinate.latitude
            Location.shareInstance.longitude = currentLocation.coordinate.longitude
            
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
            
            currentWeather.downloadWeatherDetails {
                // update ui
                self.downloadWeatherForecastData {
                    self.updateMainUI()
                }
                
            }
            
        } else{
            locationManager.requestWhenInUseAuthorization()
            getUserLocation()
        }
        
    }
    
    func downloadWeatherForecastData(completed: @escaping DownloadComplete){
        let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(forecastURL).responseJSON{ response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                    
                    for obj in list {
                        self.forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(self.forecast)
                        print(obj)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
                
            }
            
            completed()
        
    }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell{
            
            let forecast = forecasts[indexPath.row]
            
             cell.configureCell(forecast: forecast)
            return cell
        } else{
            
            return WeatherCell()
        }
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func updateMainUI(){
        
        dateLabel.text = currentWeather.date
        temperatureLabel.text = "\(currentWeather.currentTemp)°"
        cityLabel.text = currentWeather.cityName
        weatherLabel.text = currentWeather.weatherType
        weatherImgae.image = UIImage(named: currentWeather.weatherType)
        
        
    }
}

