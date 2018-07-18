//
//  PlotPointsView.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 11/28/17.
//  Copyright © 2017 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import MapKit

class PlotPointsView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // 1
            guard let artwork = newValue as? Artwork else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            // 2
            markerTintColor = artwork.markerTintColor
            glyphText = String(artwork.discipline.first!)
        }
    }
}
