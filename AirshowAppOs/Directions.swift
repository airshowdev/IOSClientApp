//
//  Directions.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 2/8/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import MapKit

class Directions: UIViewController{
    
    var basePassed: String = PListConnection.loadMyBase()
    var selectedAirshowIndex: Int = 0
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedAirshowIndex = getIndexOfSelectedAirshow()
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.10))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "DIRECTIONS")
        let backButton = UIBarButtonItem(title: "<Back", style: .plain, target: nil, action: #selector (actionClick))
        
        let baseName: String = (InfoStore.getDatabase().airshows[selectedAirshowIndex]!.directions[0]?.name)!
        let xCoords: Double = (InfoStore.getDatabase().airshows[selectedAirshowIndex]!.directions[0]?.xCoord)!
        let yCoords: Double = (InfoStore.getDatabase().airshows[selectedAirshowIndex]!.directions[0]?.yCoord)!
        
        navItem.leftBarButtonItem = backButton;
        navBar.setItems([navItem], animated: false)
        
        
        let initialLocation = CLLocation(latitude: xCoords, longitude: yCoords)
        centerMapOnLocation(location: initialLocation)

        //Makes the Plot Points Object
        let homeBase = PlotPoints(title: baseName ,
                                     full: true,
                                     coordinate: CLLocationCoordinate2D(latitude: xCoords, longitude: yCoords))
        mapView.addAnnotation(homeBase)
        mapView.frame = CGRect(x: 0, y:0, width: self.view.frame.width, height: self.view.frame.height)
        mapView.delegate = self
    }//map segue
    @objc func actionClick(sender:UIBarButtonSystemItem){
        self.performSegue(withIdentifier: "DirectionsToTable", sender: self)
    }
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension Directions: MKMapViewDelegate {
    
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
