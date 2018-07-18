//
//  Performer Schedule.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 6/8/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class PerformerSchedule: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //@IBOutlet weak var navTitle: UINavigationItem!
    //@IBOutlet weak var navBar: UINavigationBar!
    var tableView: UITableView!
    var basePassed: String = PListConnection.loadMyBase()
    var selectedAirshowIndex: Int = 0
    var scheduledPerformers = [Performer]()
    var images = AirshowImages.SavedImageCache
    
    var ref = Database.database().reference()
    var databaseHandle: DatabaseHandle?
    
    override func viewDidLoad(){
        super.viewDidLoad()
         //adds the navigation bar to the view controller
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navHeight: CGFloat = self.view.frame.height * 0.10
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: navHeight))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "PERFORMER SCHEDULE")
        let backButton = UIBarButtonItem(title: "<Back", style: .plain, target: nil, action: #selector (goingBack))
        
        navItem.leftBarButtonItem = backButton
        
        navBar.setItems([navItem], animated: false)
            
        selectedAirshowIndex = getIndexOfSelectedAirshow()
        scheduledPerformers = (InfoStore.getDatabase().airshows[selectedAirshowIndex]?.InAirPerformers())!
        
        //adds the tableview to the view controller
        tableView = UITableView(frame: CGRect(x:0, y:navHeight , width:self.view.frame.width, height:self.view.frame.height - navHeight))
        self.view.backgroundColor = .gray
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .gray
        self.view.addSubview(tableView)
        
        
        
        
        let childString: String = "Airshows/" + String(selectedAirshowIndex) + "/Performers"
       databaseHandle = ref.child(childString).observe(.childChanged) { (snapshot) in
            //Update
            self.Connect()
            //Will load the changed data into the table
            self.scheduledPerformers = (InfoStore.getDatabase().airshows[self.selectedAirshowIndex]?.InAirPerformers())!
            self.tableView.reloadData()
        }
    }
    @objc func goingBack(_ sender: Any) {
        self.performSegue(withIdentifier: "ScheduleToAirshowTable", sender: self)
    }
    //counts the array to get the number of rows needed
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return scheduledPerformers.count
    }
    func tableView(_ tableView: UITableView, widthForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.width
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 8
    }
    var airshowData:Databases?
    
    //Fills Database class with airshow data
    func Connect(){
        let airshowUrl = URL(string: "https://airshowapp-d193b.firebaseio.com/.json")
        let task = URLSession.shared.dataTask(with: airshowUrl!)
        {
            (data, response, error) in let data2 = data
            
            do{
                let decoder = JSONDecoder()
                self.airshowData = try decoder.decode(Databases.self, from: data2!)
            } catch let err{ print("Err", err)}
        }
        task.resume()
        while (airshowData == nil)
        {
            usleep(10)
        }
        // print ("data loaded ezpz")
        InfoStore.setDatabase(databaseIn: airshowData!)
    }
    
    func performerStatus(performerIndex: Int) -> UIColor{
        var currentStatus: UIColor = .gray
        if(scheduledPerformers[performerIndex].inAir == "Preparing"){
            currentStatus = UIColor.gray
        }
        else if(scheduledPerformers[performerIndex].inAir == "On-Deck"){
            currentStatus = UIColor.yellow
        }
        else if(scheduledPerformers[performerIndex].inAir == "In-Air"){
            currentStatus = UIColor.green
        }
        else if(scheduledPerformers[performerIndex].inAir == "Completed"){
            currentStatus = UIColor.red
        }
        return currentStatus
    }
    
    //adds the image and text to the cell
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.backgroundColor =  performerStatus(performerIndex: indexPath.row)
        cell.textLabel?.text = scheduledPerformers[indexPath.row].name
        cell.imageView?.image = images.fetchImageWithKey(key: scheduledPerformers[indexPath.row].image as NSString)
    
 
        return cell
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
