///
//  FirstViewController.swift
//  Cervezologia
//
//  Created by Diego Martinez on 3/21/19.
//  Copyright © 2019 Diego Martinez. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 10000
    let locationManager = CLLocationManager()
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set initial location
        //let initialLocation = CLLocation(latitude: 25.6714, longitude: -100.309)
        
        mapView.delegate = self
        
        mapView.showsUserLocation = true
        
        //center map on user's current location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        
        // show artwork on map
        let cerveceria1 = Cerveceria(title: "Sierra Madre Brewing Co.", locationName: "Garza Sada", businessHours: "Horario: 12:00-0:00", type: "Cerveceria", coordinate: CLLocationCoordinate2D(latitude: 25.625068, longitude: -100.274822))
        let cerveceria2 = Cerveceria(title: "Almacen 42", locationName: "Calle de Morelos 852, Barrio Antiguo, Centro, 64000 Monterrey, N.L.", businessHours: "Horario: 14:00-2:00", type: "Bar", coordinate: CLLocationCoordinate2D(latitude: 25.666625, longitude: -100.308229))
        let cerveceria3 = Cerveceria(title: "Esquina Edison", locationName: "Thomas Alva Edison 1328, Industrial, 64440 Monterrey, N.L.", businessHours: "Horario: 9:00-22:00", type: "Depósito", coordinate: CLLocationCoordinate2D(latitude: 25.689774, longitude: -100.332832))
        
        mapView.register(CerveceriaMarkerView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        mapView.addAnnotation(cerveceria1)
        mapView.addAnnotation(cerveceria2)
        mapView.addAnnotation(cerveceria3)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let coordinateRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension FirstViewController: MKMapViewDelegate {
    
    
    //Display annotation
    /*
     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
     guard let annotation = annotation as? Cerveceria else { return nil }
     let identifier = "marker"
     var view: MKMarkerAnnotationView
     if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
     as? MKMarkerAnnotationView {
     dequeuedView.annotation = annotation
     view = dequeuedView
     } else {
     view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
     view.canShowCallout = true
     view.calloutOffset = CGPoint(x: -5, y: 5)
     view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
     }
     return view
     }*/
    
    //Opens in map the location you tapped
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Cerveceria
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}
