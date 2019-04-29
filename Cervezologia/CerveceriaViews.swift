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
            guard let cerveceria = newValue as? Cerveceria else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "direction1"), for: UIControl.State())
            rightCalloutAccessoryView = mapsButton

            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = cerveceria.subtitle
            detailCalloutAccessoryView = detailLabel
            
            markerTintColor = cerveceria.markerTintColor
            glyphText = String(cerveceria.type.first!)
        }
    }
}

class CerveceriaView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let cerveceria = newValue as? Cerveceria else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "direction"), for: UIControl.State())
            rightCalloutAccessoryView = mapsButton

             let detailLabel = UILabel()
             detailLabel.numberOfLines = 0
             detailLabel.font = detailLabel.font.withSize(12)
             detailLabel.text = cerveceria.subtitle
             detailCalloutAccessoryView = detailLabel
        }
    }
}

