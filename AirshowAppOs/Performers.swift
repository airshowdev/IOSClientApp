//
//  Performers.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 1/18/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import UIKit

import Firebase
import FirebaseDatabase

class Performers: UIViewController, UITableViewDelegate, UITableViewDataSource{
    

    //tableview variable
    @IBOutlet weak var tableView: UITableView!
    var aircraftPassing:String = ""
    var performerDescription: Int = 0
    var sendingPage: String = "Performers"
    var basePassed: String = PListConnection.loadMyBase()
    var selectedAirshowIndex: Int = 0
    var aircrafts = [Performer]()
    var images = AirshowImages.SavedImageCache
    
    
    var ref = Database.database().reference()
    var databaseHandle: DatabaseHandle?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navHeight: CGFloat = self.view.frame.height * 0.10
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: navHeight))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "PERFORMERS")
        let backButton = UIBarButtonItem(title: "<Back", style: .plain, target: nil, action: #selector (goBack))
        
        navItem.leftBarButtonItem = backButton
        
        navBar.setItems([navItem], animated: false)
        
        selectedAirshowIndex = getIndexOfSelectedAirshow()
        aircrafts = (InfoStore.getDatabase().airshows[selectedAirshowIndex]?.InAirPerformers())!
        //adds the navigation bar to the view controller
        self.view.backgroundColor = .gray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .gray
        
        
        
        let childString: String = "Airshows/" + String(selectedAirshowIndex) + "/Performers"
        databaseHandle = ref.child(childString).observe(.childAdded) { (snapshot) in
            //Update
            self.Connect()
            //Will load the changed data into the table
            self.aircrafts = (InfoStore.getDatabase().airshows[self.selectedAirshowIndex]?.InAirPerformers())!
            self.tableView.reloadData()
        }
        
        
    }
    
    
    var airshowData:Databases?
    
    func Connect(){
        let airshowUrl = URL(string: "https://airshowapp-d193b.firebaseio.com/.json")
        // var request = URLRequest(url: airshowUrl!)
        let task = URLSession.shared.dataTask(with: airshowUrl!)
        {
            (data, response, error) in let data2 = data
            // print("Data begins being read")
            
            do{
                let decoder = JSONDecoder()
                self.airshowData = try decoder.decode(Databases.self, from: data2!)
            } catch let err{ print("Err", err)}
        }
        // print("Database Populated")
        task.resume()
        // print("Process continues after DB population")
        // print("started loading boiii")
        while (airshowData == nil)
        {
            usleep(10)
        }
        // print ("data loaded ezpz")
        InfoStore.setDatabase(databaseIn: airshowData!)
    }
    @objc func goBack(_ sender: Any) {
        self.performSegue(withIdentifier: "PerformersToAttractions", sender: self)
    }
    //counts the array to get the number of rows needed
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return aircrafts.count
    }
    //adjust the size of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 8
    }
    func tableView(_ tableView: UITableView, widthForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.width
    }
    //adds the image and text to the cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.aircraftLabel.text = aircrafts[indexPath.row].name as? String
        cell.aircraftImage?.image = images.fetchImageWithKey(key: aircrafts[indexPath.row].image as NSString)
        
    
        return cell
    }
    //Code for the items in the table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(aircrafts[indexPath.row].name)")
        //takes the user to the map if parking is selected
        aircraftPassing = aircrafts[indexPath.row].name
        performerDescription = indexPath.row
            self.performSegue(withIdentifier: "PerformersToAircraftDescriptions", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is AircraftDescriptions
           {
              let myVC = segue.destination as? AircraftDescriptions
               myVC?.receivingPage = sendingPage
              myVC?.aircraftPassed = aircraftPassing
              myVC?.aircraftDescription = performerDescription
            }
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
        // Dispose of any resources that can be recreated.
    }
}

