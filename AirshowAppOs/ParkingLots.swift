//
//  ParkingLots.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 6/7/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class ParkingLots: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var myArray = [String]()
    var parkingLot: Int = 0
    
    var ref = Database.database().reference()
    var databaseHandle: DatabaseHandle?
   
    
    private var myTableView: UITableView!
    var basePassed: String = PListConnection.loadMyBase()
    var selectedAirshowIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Inserts the name of the base into the array
        
        selectedAirshowIndex = getIndexOfSelectedAirshow()
        myArray = (InfoStore.getDatabase().airshows[selectedAirshowIndex]?.AirshowDirections())!
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navHeight: CGFloat = self.view.frame.height * 0.10
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: navHeight))
        let backButton = UIBarButtonItem(title: "<Back", style: .plain, target: nil, action: #selector (actionClick))
        let navItem = UINavigationItem(title: "Parking Lots")
        navItem.leftBarButtonItem = backButton
         self.view.addSubview(navBar)
        self.view.backgroundColor = .gray
        
        navBar.setItems([navItem], animated: false);
        
        //adds the table and cells to the view
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight + navHeight, width: displayWidth, height: displayHeight - barHeight - (self.view.frame.height * 0.10)))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.backgroundColor = .gray
        self.view.addSubview(myTableView)
        
        let childString: String = "Airshows/" + String(selectedAirshowIndex) + "/Directions"
        databaseHandle = ref.child(childString).observe(.childChanged) { (snapshot) in
            //Update
            self.Connect()
            //Will load the changed data into the table
            self.myArray = (InfoStore.getDatabase().airshows[self.selectedAirshowIndex]?.AirshowDirections())!
            self.myTableView.reloadData()
        }
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
    @objc func actionClick(sender:UIBarButtonSystemItem){
        self.performSegue(withIdentifier: "LotsToAirshowTable", sender: self)
    }
    //Code for the items in the table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
        //performs the segue with the name of the chosen path
        parkingLot = indexPath.row
        self.performSegue(withIdentifier: "ParkingLot", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is MapForParking{
            let destination = segue.destination as! MapForParking
            destination.whichParkingLot = parkingLot
            //NEEDS TO PASS THE PARKING LOT SELECTED
            
        }
    }
    //counts the number of objects in the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    func fullorNot(parkingIndex: Int) -> String{
        var spaceAvailable: String = ""
        
        if(InfoStore.getDatabase().airshows[selectedAirshowIndex]?.directions[parkingIndex]?.full == false){
         spaceAvailable = " has SPACE AVAILABLE"
        }
        else if(InfoStore.getDatabase().airshows[selectedAirshowIndex]?.directions[parkingIndex]?.full == true){
            spaceAvailable = " is Full"
        }
        return spaceAvailable
    }
    //adds cell to the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        let parking = (InfoStore.getDatabase().airshows[selectedAirshowIndex]?.directions[indexPath.row]?.name)!
        cell.textLabel!.text = parking + fullorNot(parkingIndex: indexPath.row)
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = .gray
        cell.textLabel!.textColor = .white
        return cell
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

