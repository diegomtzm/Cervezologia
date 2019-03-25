//
//  FirstViewController.swift
//  Cervezologia
//
//  Created by Diego Martinez on 3/21/19.
//  Copyright © 2019 Diego Martinez. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
let regionRadius: CLLocationDistance = 10000

func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    mapView.setRegion(coordinateRegion, animated: true)
}

override func viewDidLoad() {
    super.viewDidLoad()
    
    // set initial location in Honolulu
    let initialLocation = CLLocation(latitude: 25.6714, longitude: -100.309)
    
    centerMapOnLocation(location: initialLocation)
    
    // show artwork on map
    let cerveceria = Cerveceria(title: "Sierra Madre Brewing Co.", locationName: "Garza Sada", coordinate: CLLocationCoordinate2D(latitude: 25.625068, longitude: -100.274822))
    mapView.addAnnotation(cerveceria)
    
}
}


