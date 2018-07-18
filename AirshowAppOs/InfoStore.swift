//
//  InfoStore.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 5/8/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import Foundation

class InfoStore
{
    static var database: Databases?
    
    static func setDatabase(databaseIn: Databases)
    {
        database = databaseIn
    }
    
    static func getDatabase() -> Databases
    {
        return database!
    }
}
