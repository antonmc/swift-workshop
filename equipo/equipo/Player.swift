//
//  Player.swift
//  equipo
//
//  Created by Anton McConville on 2016-05-14.
//  Copyright © 2016 IBM. All rights reserved.
//

import Foundation

import MapKit

class Player: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var latitude: Double
    var longitude:Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}