//
//  WeatherCell.swift
//  RainyShinyCloudy
//
//  Created by James Thomson on 16/02/2017.
//  Copyright © 2017 James Thomson. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var highTempLbl: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    func configureCell(forecast: Forecast)
    {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .down
        let formatedLow = formatter.string(from: NSNumber(value: forecast.lowTemp))
        let formatedHigh = formatter.string(from: NSNumber(value: forecast.highTemp))
        
        lowTempLabel.text = "\(formatedLow!)°"
        highTempLbl.text = "\(formatedHigh!)°"
        weatherTypeLabel.text = forecast.weatherType.capitalized
        dateLabel.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType.capitalized)
        
    }
}
