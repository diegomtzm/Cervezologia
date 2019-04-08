//
//  CerveceriaViews.swift
//  Cervezologia
//
//  Created by Diana Barrios on 4/8/19.
//  Copyright © 2019 Diego Martinez. All rights reserved.
//
import UIKit
import MapKit

class CerveceriaMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let ceveceria = newValue as? Cerveceria else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "maps-icon"), for: UIControl.State())
            rightCalloutAccessoryView = mapsButton

            
            markerTintColor = ceveceria.markerTintColor
            glyphText = String(ceveceria.type.first!)
        }
    }
}
