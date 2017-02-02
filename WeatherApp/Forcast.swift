//
//  Forcast.swift
//  WeatherApp
//
//  Created by Adam Seppi on 2/1/17.
//  Copyright © 2017 AdamSeppi. All rights reserved.
//

import UIKit
import Alamofire

class Forcast {
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
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
    
    init(weatherDict: Dictionary<String, AnyObject>){
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let low = temp["min"] as? Double {
                let kelvinPreDiv = ((low * (9/5)) - 459.67)
                let far = Double(round(kelvinPreDiv))
                self._lowTemp = "\(far)"
            }
            if let high = temp["max"] as? Double {
                let kelvinPreDiv = ((high * (9/5)) - 459.67)
                let far = Double(round(kelvinPreDiv))
                self._highTemp = "\(far)"
            }
        }
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>]{
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
            
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormat = DateFormatter()
            dateFormat.dateStyle = .full
            dateFormat.dateFormat = "EEEE"
            dateFormat.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
    }
    
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "EEEE"
        return dateFormat.string(from: self)
    }
}
