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

class CerveceriaView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let cerveceria = newValue as? Cerveceria else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "maps-icon"), for: UIControl.State())
            rightCalloutAccessoryView = mapsButton

            /*
            let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            label1.numberOfLines = 0
            label1.font = label1.font.withSize(12)
            label1.text = cerveceria.subtitle
            detailCalloutAccessoryView = label1;
            
            let width = NSLayoutConstraint(item: label1, attribute: nsla, relatedBy: <#T##NSLayoutConstraint.Relation#>, toItem: <#T##Any?#>, attribute: <#T##NSLayoutConstraint.Attribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>)
            label1.addConstraint(width)
           // label1.addConstraint(width)
            
            
            //let height =
            //label1.addConstraint(height)
            */
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = cerveceria.subtitle
            detailCalloutAccessoryView = detailLabel

        }
    }
}

