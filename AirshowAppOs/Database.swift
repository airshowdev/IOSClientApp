//
//  Database.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 4/19/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let database = try? JSONDecoder().decode(Database.self, from: jsonData)

import Foundation



class Databases: Codable {
    var airshows: [Airshow?] = []
    var questions: [Question?] = []
    var messages:[Message?] = []
    enum CodingKeys: String, CodingKey {
        case airshows = "Airshows"
        case questions = "Questions"
        case messages = "Messages"
    }


    func AirshowNames() -> [String]
    {
        var airshowNames = [String]()
        for airshow in airshows
        {
            if (airshow != nil)
            {
                airshowNames.append((airshow?.name)!)
            }
        }
        return airshowNames
    }
    func AirshowQuestions() -> [String]{
        
        var airshowQuestions = [String]()

        
        for question in questions
        {
            if(question != nil)
            {
                airshowQuestions.append((question?.question)!)
            }
        }
        return airshowQuestions
    }
}



class Airshow: Codable {
    var base: String
    var date: String
    var description: String
    var directions: [Direction?] = []
    var facebookLink: String
    var foods: [Food?] = []
    var instagramLink: String
    var name: String
    var performers: [Performer?] = []
    var sponsors:String
    var statics: [StaticDisplays?] = []
    var twitterLink: String
    var websiteLink: String
    
    
    enum CodingKeys: String, CodingKey {
        case base = "Base"
        case date = "Date"
        case description = "Description"
        case directions = "Directions"
        case facebookLink = "Facebook Link"
        case foods = "Foods"
        case instagramLink = "Instagram Link"
        case name = "Name"
        case performers = "Performers"
        case sponsors = "Sponsors"
        case statics = "Statics"
        case twitterLink = "Twitter Link"
        case websiteLink = "Website Link"
    }
    
    func AirshowFood() -> [String]{
        var airshowFood = [String]()
        
        for food in foods
        {
            if(food != nil)
            {
                airshowFood.append((food?.name)!)
            }
        }
        return airshowFood
    }
    func InAirPerformers() -> [Performer]{
        var airshowPerformers = [Performer]()
        //let newArray = [String]()
        
        for performer in performers
        {
            if(performer != nil)
            {
                airshowPerformers.append((performer)!)
                //airshowPerformers.sorted(by: {$0.name < $1.name})
            }
        }
        //code to sort by performer order
        airshowPerformers =  airshowPerformers.sorted{ (id1, id2) -> Bool in
            return id1.orderNumber < id2.orderNumber
        }
        return airshowPerformers
    }
    
    
    
    func AirshowDirections() -> [String]{
        var airshowDirections = [String]()
        
        for direction in directions
        {
            if(direction != nil)
            {
                airshowDirections.append((direction?.name)!)
            }
        }
        return airshowDirections
    }
    func groundDisplays() -> [String]{
        var airshowStatics = [String]()
        
        for staticDisplay in statics
        {
            if(staticDisplay != nil)
            {
                airshowStatics.append((staticDisplay?.name)!)
            }
        }
        return airshowStatics
    }

 
}


class Direction: Codable {
    let full: Bool
    let name:String
    let type: String
    let xCoord:Double
    let yCoord: Double 
    
    enum CodingKeys: String, CodingKey {
        case full = "Full"
        case name = "Name"
        case type = "Type"
        case xCoord = "X-Coord"
        case yCoord = "Y-Coord"
    }
}

class Food: Codable {
    let description: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case description = "Description"
        case name = "Name"
    }
}

class Performer: Codable {
    let description: String
    let image: String
    let inAir: String?
    let name: String
    let orderNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case description = "Description"
        case image = "Image"
        case inAir = "In Air"
        case name = "Name"
        case orderNumber = "Order Number"
    }
}

class StaticDisplays: Codable {
    let description: String
    let name: String 
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case description = "Description"
        case image = "Image"
        case name = "Name"
    }
}

class Question: Codable {
    let answer: String
    let question: String
    
    enum CodingKeys: String, CodingKey {
        case answer = "Answer"
        case question = "Question"
    }
}
class Message: Codable {
    let body:String
    let date: String
    let id: String
    let title: String
    let uid: String
    
    enum CodingKeys: String, CodingKey{
        case body = "body"
        case date = "date"
        case id = "id"
        case title = "title"
        case uid = "uid"
    }
}
