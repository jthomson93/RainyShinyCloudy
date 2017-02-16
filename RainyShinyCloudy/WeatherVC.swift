//
//  ViewController.swift
//  RainyShinyCloudy
//
//  Created by James Thomson on 05/02/2017.
//  Copyright © 2017 James Thomson. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentLocationLabel: UILabel!
    
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()

    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() //Request authorisation
        locationManager.startMonitoringSignificantLocationChanges() //Monitors significant changes
        
        tableView.delegate = self //Data is handled from within the cell
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetails
        {
            self.downloadForecast
            {
              self.updateMainUI()
            }
        }
    }
    
    func downloadForecast(completed: @escaping DownloadComplete)
    {
        //Downloading forecast weather data for TableView
        let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>
            {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]
                {
                    
                    for obj in list
                    {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.tableView.reloadData()
                }
            }
        }
        completed()
    }
    
    //REQUIRED FOR TABLESVIEWS
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    //REQUIRED FOR TABLESVIEWS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return forecasts.count
    }
    
    //REQUIRED FOR TABLESVIEWS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //Looks for cell with identifier and ensures that data moves between cells as opposed to wasting memory. Uses cell recycling.
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell //Looks for cell identifier and index path.
        {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func updateMainUI()
    {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherTypeLabel.text = currentWeather.weatherType.capitalized
        currentLocationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType.capitalized)
        print(currentWeather.weatherType.capitalized)
    }
    
    func locationAuthStatus()
    {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse //Checks to see if we are authorised to use users location
        {
            currentLocation = locationManager.location // If authorised, grab user location
        } else {
            locationManager.requestWhenInUseAuthorization() // Else, if not, ask for authorisation
            locationAuthStatus()
        }
    }


}

