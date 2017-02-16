//
//  Constants.swift
//  RainyShinyCloudy
//
//  Created by James Thomson on 10/02/2017.
//  Copyright © 2017 James Thomson. All rights reserved.
//

import Foundation



let BASE_URL =  "http://api.openweathermap.org//data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "945cba1d87879a58d7edbe05d05aed88"
var setLong = 0.0
var setLat = 0.0

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(setLat)\(LONGITUDE)\(setLong)\(APP_ID)\(API_KEY)"


let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(setLat)&lon=\(setLong)&cnt=10&appid=945cba1d87879a58d7edbe05d05aed88"

