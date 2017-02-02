//
//  Constants.swift
//  WeatherApp
//
//  Created by Adam Seppi on 2/1/17.
//  Copyright © 2017 AdamSeppi. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"

let LATITUDE = "lat="
let LONGITUDE = "&lon="
let API_KEY = "06ccaf97b7e457dbc633a62bd1ed38a4"
let APP_ID = "&appid="

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"

let FORCAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=06ccaf97b7e457dbc633a62bd1ed38a4"
