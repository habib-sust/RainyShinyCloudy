//
//  CurrentWeather.swift
//  RainShinyCloudy
//
//  Created by Habibur Rahman on 5/4/17.
//  Copyright © 2017 Habibur Rahman. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        
        if _date == nil {
            _date = ""
        }
        
        let dateFormtter = DateFormatter()
        dateFormtter.dateStyle = .long
        dateFormtter.timeStyle = .none
        
        let currentDate = dateFormtter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    
    var weatherType: String {
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        // dowanload current weather data
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherURL).responseJSON { response in
            
            let result = response.result
            
            print(response)
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let name = dict["name"] as? String{
                    self._cityName = name
                    print(self._cityName)
                    
                }
                
                if let weather = dict["weather"] as? [Dictionary <String, AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String {
                        
                        self._weatherType = main
                        print(self._weatherType)
                    }
                }
                
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let currentTemperature = main["temp"] as? Double{
                        let kelvinToCelcius = currentTemperature - 273.14
                        self._currentTemp = Double(round(kelvinToCelcius))
                        print(self._currentTemp)
                    }
                    
                }
                
            }
           completed()
        }
        
        
    }
    
}
