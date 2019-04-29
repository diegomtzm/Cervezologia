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
        let cerveceria1 = Cerveceria(title: "Sierra Madre Brewing Co.", locationName: "Av. Eugenio Garza Sada 4373, Contry, 64860 Monterrey, N.L.", businessHours: "Horario: 12:00-0:00", type: "Cerveceria", coordinate: CLLocationCoordinate2D(latitude: 25.625068, longitude: -100.274822))
        let cerveceria2 = Cerveceria(title: "Almacen 42", locationName: "Calle de Morelos 852, Barrio Antiguo, Centro, 64000 Monterrey, N.L.", businessHours: "Horario: 14:00-2:00", type: "Bar", coordinate: CLLocationCoordinate2D(latitude: 25.666625, longitude: -100.308229))
        let cerveceria3 = Cerveceria(title: "Esquina Edison", locationName: "Thomas Alva Edison 1328, Industrial, 64440 Monterrey, N.L.", businessHours: "Horario: 9:00-22:00", type: "Depósito", coordinate: CLLocationCoordinate2D(latitude: 25.689774, longitude: -100.332832))
        let cerveceria4 = Cerveceria(title: "Beer For Us", locationName: "Av Alfonso Reyes 341 Contry, El Tesoro, 64850 Monterrey, N.L.", businessHours: "Horario: 11:00-21:00", type: "Depósito", coordinate: CLLocationCoordinate2D(latitude: 25.643898, longitude: -100.276195))
        let cerveceria5 = Cerveceria(title: "Lupulo Cerveza Store", locationName: "Calle Río Mississippi 490, Col. del Valle, 66220 San Pedro Garza García, N.L.", businessHours: "Horario: 13:00-21:00", type: "Bar", coordinate: CLLocationCoordinate2D(latitude: 25.656307, longitude: -100.357465))
        let cerveceria6 = Cerveceria(title: "Feroz", locationName: "Av. Del Estado 215, Tecnológico, 64700 Monterrey, N.L.", businessHours: "Horario: 17:00-01:00", type: "Bar", coordinate: CLLocationCoordinate2D(latitude: 25.661366, longitude: -100.294307))
        let cerveceria7 = Cerveceria(title: "La Taberna - House of Brews", locationName: "Av. Eugenio Garza Sada 2410, Roma, 64700 Monterrey, N.L.", businessHours: "Horario: 17:00-01:00", type: "Bar", coordinate: CLLocationCoordinate2D(latitude: 25.653093, longitude: -100.293700))
        let cerveceria8 = Cerveceria(title: "Santa Co. Taproom", locationName: "Blvrd Acapulco 3948, Torre Brisas, Las Brisas 10o. Sector, 64780 Monterrey, N.L.", businessHours: "Horario: 18:00-00:00", type: "Bar", coordinate: CLLocationCoordinate2D(latitude: 25.622224, longitude: -100.284352))
        
        
        mapView.register(CerveceriaMarkerView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        mapView.addAnnotation(cerveceria1)
        mapView.addAnnotation(cerveceria2)
        mapView.addAnnotation(cerveceria3)
        mapView.addAnnotation(cerveceria4)
        mapView.addAnnotation(cerveceria5)
        mapView.addAnnotation(cerveceria6)
        mapView.addAnnotation(cerveceria7)
        mapView.addAnnotation(cerveceria8)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let coordinateRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
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
