//
//  VendorsViewController.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 3/1/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import UIKit

class Vendors: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var basePassed: String = PListConnection.loadMyBase()
    var selectedAirshowIndex: Int = 0

    var tableView: UITableView!
    var vendors: NSArray!

    override func viewDidLoad(){
            super.viewDidLoad()
        vendors = InfoStore.getDatabase().airshows[selectedAirshowIndex]?.AirshowFood() as! NSArray
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navHeight: CGFloat = self.view.frame.height * 0.10
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: navHeight))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "VENDORS")
        let backButton = UIBarButtonItem(title: "<Back", style: .plain, target: nil, action: #selector (goBack))
        
        navItem.leftBarButtonItem = backButton
        
        navBar.setItems([navItem], animated: false)
            //adds the navigation bar to the view controller
            self.view.backgroundColor = .gray
        //adds the tableview to the view controller
        tableView = UITableView(frame: CGRect(x:0, y:navHeight , width:self.view.frame.width, height:self.view.frame.height - navHeight))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .gray
        self.view.addSubview(tableView)
        
    
        }
        @objc func goBack(_ sender: Any) {
            self.performSegue(withIdentifier: "VendorsToAttractions", sender: self)
        }
        //counts the array to get the number of rows needed
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return vendors.count
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell")
            
            cell?.textLabel?.text = vendors[indexPath.row] as? String
            cell?.textLabel?.textAlignment = .center
            cell?.backgroundColor = .gray
            cell?.textLabel?.textColor = .white
            
            return cell!
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

}
