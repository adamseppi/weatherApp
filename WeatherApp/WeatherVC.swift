//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Adam Seppi on 2/1/17.
//  Copyright © 2017 AdamSeppi. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import MapKit

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var currentTempLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var currentWeatherDesc: UILabel!
    @IBOutlet var currentWeatherImg: UIImageView!
    @IBOutlet var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currLoc: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forcast: Forcast!
    var forcasts = [Forcast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //print("\(CURRENT_WEATHER_URL)")
        currentWeather = CurrentWeather()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
        
        currentWeather.downloadWeatherDetails {
            self.downloadForcast{
                self.updateMainUIblah()
            }
        }
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currLoc = locationManager.location
            Location.sharedInstance.longitude = currLoc.coordinate.longitude
            Location.sharedInstance.latitude = currLoc.coordinate.latitude
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForcast(completed: @escaping DownloadComplete){
        let forcastURL = URL(string: FORCAST_URL)!
        
        Alamofire.request(forcastURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let forcast = Forcast(weatherDict: obj)
                        self.forcasts.append(forcast)
                    }
                    //self.forcasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forcast = forcasts[indexPath.row]
            cell.configureCell(forcast: forcast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forcasts.count
    }
    
    func updateMainUIblah() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        print("CurrTemp = \(currentWeather.currentTemp)")
        currentWeatherDesc.text = currentWeather.weatherType
        print("CurrType = \(currentWeather.weatherType)")
        locationLabel.text = currentWeather.cityName
        print("CurrCity = \(currentWeather.cityName)")
        currentWeatherImg.image = UIImage(named: currentWeather.weatherType)
    }
}

