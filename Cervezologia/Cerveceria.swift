//
//  Cerveceria.swift
//  Cervezologia
//
//  Created by Diana Barrios on 3/25/19.
//  Copyright © 2019 Diego Martinez. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class Cerveceria: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
