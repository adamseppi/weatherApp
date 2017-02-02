//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Adam Seppi on 2/1/17.
//  Copyright © 2017 AdamSeppi. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet var weatherIcon: UIImageView!

    @IBOutlet var dayLabel: UILabel!
    
    @IBOutlet var weatherTypeLabel: UILabel!
    
    @IBOutlet var highLabel: UILabel!
    
    @IBOutlet var lowLabel: UILabel!
    
    func configureCell(forcast: Forcast) {
        dayLabel.text = forcast.date
        highLabel.text = "\(forcast.highTemp)"
        lowLabel.text = "\(forcast.lowTemp)"
        weatherTypeLabel.text = forcast.weatherType
        weatherIcon.image = UIImage(named: forcast.weatherType)
    }
    
    
}
