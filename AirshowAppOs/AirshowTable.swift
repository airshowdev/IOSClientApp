//
//  AirshowTable.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 11/28/17.
//  Copyright © 2017 Dev Lab Mac 2. All rights reserved.
//
import Firebase
import Foundation
import UIKit
//import GoogleMobileAds

class   AirshowTable: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    
    
    private var myArray = ["ATTRACTIONS","DIRECTIONS","PARKING","SPONSORS","SOCIAL MEDIA","PROHIBITED ITEMS","FAQ","SETTINGS"]
    
    private var myTableView: UITableView!
    var basePassed: String = PListConnection.loadMyBase()
    var selectedAirshowIndex: Int = 0
    var images = AirshowImages.SavedImageCache
    
    private var myImageView: UIImageView!
    private var sponsorImages: [UIImage] = []
    var selectedPerformer: Int = 0
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        //if(isItToday() == false){
        if(isItToday()){
            myArray.insert("PERFORMERS SCHEDULE", at: 1)
        }
        for sponsor in (InfoStore.getDatabase().airshows[selectedAirshowIndex]?.InAirPerformers())!
        {
                 sponsorImages.append(images.fetchPerformerImageByAirshowIndex(staticIndex: selectedPerformer, airshowIndex: selectedAirshowIndex))
                selectedPerformer += 1

        }
        selectedAirshowIndex =  0
        //Inserts the name of the base into the array
        myArray.insert("About " + (InfoStore.database?.airshows[selectedAirshowIndex]?.base)!, at: 7)
    
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navHeight: CGFloat = self.view.frame.height * 0.10
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: navHeight))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: basePassed)
      
        navBar.setItems([navItem], animated: false)
        
        //adds the table and cells to the view
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight + navHeight, width: displayWidth, height: displayHeight - barHeight - (self.view.frame.height * 0.10)))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.backgroundColor = .gray
        self.view.addSubview(myTableView)
        Countdown()
        
    }
    func isItToday() -> Bool{
        let date = NSDate()
        let calendar = Calendar.current
        let componets = calendar.dateComponents([ .month, .year, .day], from: date as Date)
        let currentDate = calendar.date(from: componets)
        let userCalendar = Calendar.current
        //retrieves the date of the airshow
        let airshowDate: String = (InfoStore.database?.airshows[selectedAirshowIndex]?.date)!
        //sets the date of the airshow in the program
        let airshowMonth = Int(airshowDate.dropLast(8))
        let airshowYear = Int(airshowDate.dropFirst(6))
        let airshowDate2 = airshowDate.dropFirst(3)
        let airshowDay = Int(airshowDate2.dropLast(5))
        let AirShowDate = NSDateComponents()
        AirShowDate.year = airshowYear!
        AirShowDate.month = airshowMonth!
        AirShowDate.day = airshowDay!
        let AirShowDay = userCalendar.date(from: AirShowDate as DateComponents)
        //calualtes the amount of days between the current date and the date of the airshow
        let AirShowDayDifference = calendar.dateComponents([ .day], from: currentDate!, to: AirShowDay!)
        if(AirShowDayDifference.day == 0){
            return true
        }
        else{
            return false
        }
    }
    @objc func Countdown()   {
        
        let date = NSDate()
        let calendar = Calendar.current
        let componets = calendar.dateComponents([ .month, .year, .day], from: date as Date)
        let currentDate = calendar.date(from: componets)
        let userCalendar = Calendar.current
        
        
        //retrieves the date of the airshow
        let airshowDate: String = (InfoStore.database?.airshows[selectedAirshowIndex]?.date)!
        //sets the date of the airshow in the program
        

        let airshowMonth = Int(airshowDate.dropLast(8))
        let airshowYear = Int(airshowDate.dropFirst(6))
        let airshowDate2 = airshowDate.dropFirst(3)
        let airshowDay = Int(airshowDate2.dropLast(5))

        let AirShowDate = NSDateComponents()
        AirShowDate.year = airshowYear!
        AirShowDate.month = airshowMonth!
        AirShowDate.day = airshowDay!
        let AirShowDay = userCalendar.date(from: AirShowDate as DateComponents)
        print("Airshow Date is:" , AirShowDay)
        //calualtes the amount of days between the current date and the date of the airshow
        let AirShowDayDifference = calendar.dateComponents([ .day], from: currentDate!, to: AirShowDay!)
        
        let daysLeft = AirShowDayDifference.day
        //adds the countdown label
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navHeight: CGFloat = self.view.frame.height * 0.10
        let countdownLabel = UILabel(frame: CGRect(x:0, y:navHeight+10, width:self.view.frame.width, height:barHeight+10))
        //Sets text color based on how many days are left
        if ( daysLeft! > 30)
        {
            countdownLabel.textColor = .green
        }
        else if ( daysLeft! > 7)
        {
            countdownLabel.textColor = .yellow
        }
        else if ( daysLeft! > 1)
        {
            countdownLabel.textColor = .red
        }
        if ( daysLeft! == 0)
        {
            countdownLabel.text = (InfoStore.database?.airshows[selectedAirshowIndex]?.name)! + " is today"
        }
        
        countdownLabel.textAlignment = .center
        countdownLabel.backgroundColor = .gray
        //displays the number of days until the chosen airshow
        countdownLabel.text = "\(daysLeft ?? 0) Days Until " + (InfoStore.database?.airshows[selectedAirshowIndex]?.name)!
        if (daysLeft! < 0)
        {
            countdownLabel.text = (InfoStore.database?.airshows[selectedAirshowIndex]?.name)! + " has passed"
        }
        self.view.addSubview(countdownLabel)
    }
    //Code for the items in the table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        
        if(isItToday()){
            switch indexPath.row {
            case 4:
                let sponsorsLink = (InfoStore.database?.airshows[selectedAirshowIndex]?.sponsors)!
                if let urlSponsors = NSURL(string: sponsorsLink){UIApplication.shared.openURL(urlSponsors as URL)}
            case 8:
                self.performSegue(withIdentifier: "ABOUT", sender: self)
            default:
                self.performSegue(withIdentifier: myArray[indexPath.row], sender: self)
            }
        }
        else{
            switch indexPath.row {
            case 3:
                let sponsorsLink = (InfoStore.database?.airshows[selectedAirshowIndex]?.sponsors)!
                if let urlSponsors = NSURL(string: sponsorsLink){UIApplication.shared.openURL(urlSponsors as URL)}
            case 7:
                self.performSegue(withIdentifier: "ABOUT", sender: self)
            default:
                self.performSegue(withIdentifier: myArray[indexPath.row], sender: self)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return myTableView.frame.height / CGFloat(myArray.count)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is NewSocialMedia{
            let destination = segue.destination as! NewSocialMedia
            destination.selectedAirshowIndex = getIndexOfSelectedAirshow()
        }
        
    }
    
    //counts the number of objects in the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    //adds cell to the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(myArray[indexPath.row])"
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
        return 0
        /*var index: Int = 0
         for airshow in InfoStore.getDatabase().airshows {
         if (airshow?.name == basePassed){
         return index
         } else {
         index += 1
         }
         }
         return 200
         */
    }
}

