//
//  BasePoint.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 2/21/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import MapKit

class BasePoint: NSObject, MKAnnotation {
    var title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, availability: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
}
