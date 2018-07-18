//
//  ReadPlist.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 12/11/17.
//  Copyright © 2017 Dev Lab Mac 2. All rights reserved.
//

import Foundation
class ReadPlist{
    
    func viewDidLoad() {
        
    }
    func didReceiveMemoryWarning() {
        
    }
    //Method will create plist containing base names
    func storedAirshows() {
        var myAirshows: NSDictionary?
        if let path = Bundle.main.path(forResource: "Airshows", ofType: "plist") {
            myAirshows = NSDictionary(contentsOfFile: path)
        }
        var baseArray = [String]()
        for (value) in myAirshows!{
            baseArray.append("\(value)")
        }
    }
    
}
