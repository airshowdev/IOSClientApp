//
//  ParkingMap.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 11/27/17.
//  Copyright © 2017 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapForParking: UIViewController{



    @IBOutlet weak var MapParking: MKMapView!
    var whichParkingLot: Int = 0
    var basePassed: String = PListConnection.loadMyBase()
    var selectedAirshowIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray

        let parkingName: String = (InfoStore.getDatabase().airshows[selectedAirshowIndex]!.directions[whichParkingLot]?.name)!
        let xCoords: Double = (InfoStore.getDatabase().airshows[selectedAirshowIndex]!.directions[whichParkingLot]?.xCoord)!
        let yCoords: Double = (InfoStore.getDatabase().airshows[selectedAirshowIndex]!.directions[whichParkingLot]?.yCoord)!
        let status: Bool = (InfoStore.getDatabase().airshows[selectedAirshowIndex]!.directions[whichParkingLot]?.full)!
        
        let initialLocation = CLLocation(latitude: xCoords, longitude: yCoords)
        centerMapOnLocation(location: initialLocation)
        //adds the navigation bar to the view
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.10))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: parkingName)
        let backButton = UIBarButtonItem(title: "<Back", style: .plain, target: nil, action: #selector (actionClick))
        //Makes the Plot Points Object
        let ParkingLot1 = PlotPoints(title: parkingName,
                                     full: status,
                                     coordinate: CLLocationCoordinate2D(latitude: xCoords, longitude: yCoords))
        
        navItem.leftBarButtonItem = backButton;
        navBar.setItems([navItem], animated: false)

        

        //Adds plot points to the map
        MapParking.addAnnotation(ParkingLot1)

        
        MapParking.frame = CGRect(x: 0, y:self.view.frame.height * 0.10, width: self.view.frame.width, height: self.view.frame.height)
        MapParking.delegate = self

    }
    //map segue
    @objc func actionClick(sender:UIBarButtonSystemItem){
        self.performSegue(withIdentifier: "BackToLots", sender: self)
    }

    //Sets the region that shows on the phone screen
    let regionRadius: CLLocationDistance = 1500
    func centerMapOnLocation(location:CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        MapParking.setRegion(coordinateRegion, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getIndexOfSelectedAirshow() -> Int{
        var index: Int = 0
        for airshow in InfoStore.getDatabase().airshows {
            if (airshow?.name == basePassed){
                return index
            } else {
                index += 1
            }
        }
        return 200
    }
    
}
extension MapForParking: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? PlotPoints else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! PlotPoints
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}
