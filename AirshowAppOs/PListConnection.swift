//
//  PListConnection.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 5/30/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import UIKit

class PListConnection{
    
   
    
    public static func loadMyBase() -> String{
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentDirectory = paths.object(at: 0) as! String
        let bundlePath = documentDirectory.appending("myBaseData.plist")
        
        let myDict = NSDictionary(contentsOfFile: bundlePath)
        if let dict = myDict{
            return dict.object(forKey: "myBase") as! String
            
        } else {
        return ""
        }
    }
        
    
    public static func saveMyBase(value:String){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentDirectory = paths.object(at: 0) as! String
        let path = documentDirectory.appending("myBaseData.plist")
        let dict:NSMutableDictionary = [:]
        dict.setObject(value, forKey: "myBase" as NSCopying)
        dict.write(toFile: path, atomically: false)
        print("saved.")
    }
}
