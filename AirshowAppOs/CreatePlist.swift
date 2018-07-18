//
//  CreatePlist.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 12/8/17.
//  Copyright © 2017 Dev Lab Mac 2. All rights reserved.
//

import Foundation

class CreatePlist{
    
     func viewDidLoad() {

    }
     func didReceiveMemoryWarning() {
        
    }
    //Method will create plist containing base names
    func availableAirshows( ) {
        let fileManager = FileManager.default
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = documentDirectory.appending("/Airshows.plist")
        if (!fileManager.fileExists(atPath: path)) {
            let dicAirshows:[Int: String] = [0 : "Offutt AFB", 1 : "Dobbins ARB"]
            let plistAirshowContent = NSDictionary(dictionary: dicAirshows)
            let success:Bool = plistAirshowContent.write(toFile: path, atomically: true)
            if success {
              // print("file has been created!")
            }else{
              //  print("unable to create the file")
           }
        }
       
      /*  else{
            print("file already exist")
        }*/
        
    }
    
}
