//
//  PlotPoints.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 11/28/17.
//  Copyright © 2017 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class PlotPoints: NSObject, MKAnnotation {
    var title: String?
    var full: Bool
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, full: Bool, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.full = full
        self.coordinate = coordinate
        
        super.init()
    }
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    var subtitle: String? {
        return title
    }
}
