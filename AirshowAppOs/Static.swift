//
//  Static.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 3/6/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import UIKit
import Foundation

 class Static: UIViewController, UITableViewDelegate, UITableViewDataSource {


    var tableView: UITableView!
    
    var staticPassing:String = ""
    var staticDescription: Int = 0
    var sendingPage: String = "Statics"
    
    var basePassed: String = PListConnection.loadMyBase()
    var selectedAirshowIndex: Int = 0
    var statics = [String]()
    var images = AirshowImages.SavedImageCache
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navHeight: CGFloat = self.view.frame.height * 0.10
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: navHeight))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "GROUND DISPLAY")
        let backButton = UIBarButtonItem(title: "<Back", style: .plain, target: nil, action: #selector (goingBack))
        
        navItem.leftBarButtonItem = backButton
        
        navBar.setItems([navItem], animated: false)
        selectedAirshowIndex = getIndexOfSelectedAirshow()
        statics = (InfoStore.getDatabase().airshows[selectedAirshowIndex]?.groundDisplays())!
        //adds the navigation bar to the view controller
        self.view.backgroundColor = .lightGray
        //adds the tableview to the view controller
        tableView = UITableView(frame: CGRect(x:0, y:navHeight , width:self.view.frame.width, height:self.view.frame.height - navHeight))
        self.view.backgroundColor = .gray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .gray
        self.view.addSubview(tableView)
 
    }
    
    @objc func goingBack(_ sender: Any) {
        self.performSegue(withIdentifier: "StaticsToAttractions", sender: self)
    }
    //counts the array to get the number of rows needed
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return statics.count
    }
    func tableView(_ tableView: UITableView, widthForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.width
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 8
    }
    //adds the image and text to the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell")
        cell?.backgroundColor = .gray
        cell?.textLabel?.text = statics[indexPath.row] as? String
        cell?.imageView?.image = images.fetchStaticImageByAirshowIndex(staticIndex: indexPath.row, airshowIndex: selectedAirshowIndex)
        return cell!
    }
    //Code for the items in the table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(statics[indexPath.row])")
        //takes the user to the map if parking is selected
        staticPassing = statics[indexPath.row]
        staticDescription = indexPath.row
        self.performSegue(withIdentifier: "StaticsToDescription", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is AircraftDescriptions
        {
            let myVC = segue.destination as? AircraftDescriptions
            myVC?.receivingPage = sendingPage
            myVC?.aircraftPassed = staticPassing
            myVC?.aircraftDescription = staticDescription
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
    
}
