//
//  Attractions.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 12/1/17.
//  Copyright © 2017 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import UIKit

import Firebase
import FirebaseDatabase

class  Attractions: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate{
    //Creates an array to populate the table
    private var attractions: [String] = ["PERFORMERS","GROUND DISPLAYS","VENDORS"]
    //tableview variable
    private var myAttractionsTable: UITableView!
    //image view variables
    private var myImageView: UIImageView!
    private var newImageView: UIImageView!
    var basePassed: String = PListConnection.loadMyBase()
    var selectedAirshowIndex: Int = 0
    
    var ref = Database.database().reference()
    var databaseHandle: DatabaseHandle?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //adds the navigation bar to the view controller
        self.view.backgroundColor = .gray
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navHeight: CGFloat = self.view.frame.height * 0.10
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: navHeight))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "ATTRACTIONS")
        let backButton = UIBarButtonItem(title: "<Back", style: .plain, target: nil, action: #selector (actionClick))
        //Adds a button to the navigation bar
        navItem.leftBarButtonItem = backButton;
        navBar.setItems([navItem], animated: false);
        
        //adds the table to the viewcontoller
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = (self.view.frame.height/2)
        myAttractionsTable = UITableView(frame: CGRect(x: 0, y: navHeight, width: displayWidth, height: displayHeight ))
        myAttractionsTable.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myAttractionsTable.dataSource = self
        myAttractionsTable.delegate = self
        myAttractionsTable.backgroundColor = .gray
        myAttractionsTable.rowHeight = (view.frame.height/8)
        self.view.addSubview(myAttractionsTable)
        
        //adds the image and image view to the view controller
        let imageWidth: CGFloat = self.view.frame.width
        let imageHeight: CGFloat = self.view.frame.height - displayHeight - navHeight
        myImageView = UIImageView(frame: CGRect(x:0, y:(self.view.frame.height/2) + navHeight, width: imageWidth, height: imageHeight))
        myImageView.image = UIImage(named: "USAFLogo")
        self.view.addSubview(myImageView)
        
        let childString: String = "Airshows/" + String(selectedAirshowIndex)
        databaseHandle = ref.child(childString).observe(.childChanged) { (snapshot) in
            //Update
            self.Connect()
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
    //Code for the back button
    //takes the user back to the previous page
    @objc func actionClick(sender:UIBarButtonSystemItem){
        self.performSegue(withIdentifier: "AttractionsToAirshow", sender: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.height * 0.5) / CGFloat(attractions.count)
    }
    //Code for the items in the table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(attractions[indexPath.row])")
        //takes the user to the map if parking is selected
        
      switch indexPath.row{
            
        case 0:
             self.performSegue(withIdentifier: "PERFORMERS", sender: self)
        case 1:
             self.performSegue(withIdentifier: "GROUND DISPLAYS", sender: self)
        case 2:
             self.performSegue(withIdentifier: "VENDORS", sender: self)
        default:
            self.performSegue(withIdentifier: attractions[indexPath.row] as! String, sender: self)
            
        }
    }
    //counts the number of objects in the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attractions.count
    }
    //adds cell to the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(attractions[indexPath.row])"
        cell.backgroundColor = .gray
        cell.textLabel!.textColor = .white
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
        return 0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
