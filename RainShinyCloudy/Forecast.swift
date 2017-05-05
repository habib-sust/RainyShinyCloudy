//
//  Forecast.swift
//  RainShinyCloudy
//
//  Created by Habibur Rahman on 5/5/17.
//  Copyright © 2017 Habibur Rahman. All rights reserved.
//

import UIKit

class Forecast{
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String{
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String{
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject>{
            
            if let min = temp["min"] as? Double {
                
                let kelvinToCelcius = min - 273.16
                _lowTemp = "\(Double(round(10*kelvinToCelcius/10)))"
                
                
            }
            
            if let max = temp["max"] as? Double {
                let kelvinToCelcius = max - 273.16
                _highTemp = "\(Double(round(kelvinToCelcius)))"
            }
            
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let main = weather[0]["main"] as? String{
                _weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double{
            
            let unixConvertDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            
            self._date = unixConvertDate.dayOfTheWeek()
            
            print(_date)
        }
        
        
        
    }
}


extension Date{
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
