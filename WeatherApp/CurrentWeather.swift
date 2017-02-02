//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Adam Seppi on 2/1/17.
//  Copyright © 2017 AdamSeppi. All rights reserved.
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today is \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
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
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //AlamoDownload
        let currentWeatherURL1 = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherURL1).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print(self.cityName)
                }
                if let weatherType = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weatherType[0]["main"] {
                        self._weatherType = main.capitalized
                        print(self.weatherType)
                    }
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currTemp = main["temp"] as? Double {
                        let kelvinPreDiv = ((currTemp * (9/5)) - 459.67)
                        let far = Double(round(kelvinPreDiv))
                        self._currentTemp = far
                        print(self.currentTemp)
                    }
                }
            }
            completed()
        }
    }
}
