//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by James Thomson on 16/02/2017.
//  Copyright © 2017 James Thomson. All rights reserved.
//

import Foundation
import CoreLocation


class Location {
    
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
