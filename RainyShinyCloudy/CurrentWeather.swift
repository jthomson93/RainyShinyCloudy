//
//  CurrentWeather.swift
//  RainyShinyCloudy
//
//  Created by James Thomson on 10/02/2017.
//  Copyright © 2017 James Thomson. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class CurrentWeather {
    
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: String!

    

    
    //DATA ENCAPSULATION
    var cityName: String
    {
        if _cityName == nil
        {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter() //Create date formatter
        dateFormatter.dateStyle = .long //Long style of dates
        dateFormatter.timeStyle = .none //No time
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String
    {
        if _weatherType == nil
        {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: String
    {
        if _currentTemp == nil
        {
            _currentTemp = ""
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete)
    {
        //Alamofire download
        
        //let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)
        
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>
            {
                if let name = dict["name"] as? String
                {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]
                {
                    if let main = weather[0]["main"] as? String
                    {
                        self._weatherType = main.lowercased()
                        print(self._weatherType)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject>
                {
                    if let currentTemperature = main["temp"] as? Double
                    {
                        let formatter = NumberFormatter()
                        formatter.maximumFractionDigits = 2
                        formatter.roundingMode = .down
                        let formattedCurrentTemp = formatter.string(from: NSNumber(value: (currentTemperature - 273)))
                        
                        self._currentTemp = "\(formattedCurrentTemp!)°"
                    }
                }
            }
          completed()
        }
    }
}
    
    

