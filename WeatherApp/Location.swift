//
//  Location.swift
//  WeatherApp
//
//  Created by Adam Seppi on 2/1/17.
//  Copyright © 2017 AdamSeppi. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
