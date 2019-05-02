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
import Contacts

class Cerveceria: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let businessHours: String
    let type: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, businessHours: String, type: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.locationName = locationName
        self.businessHours = businessHours
        self.type = type
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    // markerTintColor for types: Cerveceria, Bar, Deposito
    var markerTintColor: UIColor  {
        switch type {
        case "Cerveceria":
            return .red
        case "Bar":
            return .purple
        case "Depósito":
            return .blue
        default:
            return .green
        }
    }
    
    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
