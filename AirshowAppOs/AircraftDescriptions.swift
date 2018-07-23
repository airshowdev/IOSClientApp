//
//  AircraftDescriptions.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 4/18/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import UIKit

class AircraftDescriptions: UIViewController{
   var aircraftPassed:String = ""
    var aircraftDescription: Int = 0
    var receivingPage:String!
    
    var basePassed: String = PListConnection.loadMyBase()
    
    var selectedAirshowIndex: Int = 0
    var images = AirshowImages.SavedImageCache
    private var myAircraftImageView: UIImageView!
    //creates the textview for the page
    var theDescription = UITextView()
    var scheduledPerformers = [Performer]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navHeight: CGFloat = self.view.frame.height * 0.10
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: navHeight))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: aircraftPassed)
        let backButton = UIBarButtonItem(title: "<Back", style: .plain, target: nil, action: #selector (goBack))
        
        navItem.leftBarButtonItem = backButton
        
        navBar.setItems([navItem], animated: false)
        
        self.view.backgroundColor = .gray
        
         selectedAirshowIndex = getIndexOfSelectedAirshow()
        scheduledPerformers = (InfoStore.getDatabase().airshows[0]?.InAirPerformers())!
         let displayHeight: CGFloat = (barHeight + navHeight)
        
        //adds the image and image view to the view controller
        let imageWidth: CGFloat = self.view.frame.width
        let imageHeight: CGFloat = self.view.frame.height * 0.33
        myAircraftImageView = UIImageView(frame: CGRect(x:0, y: displayHeight, width: imageWidth, height: imageHeight))
        myAircraftImageView.image = UIImage(named:"USAFLogo")
        if(receivingPage == "Performers"){
           myAircraftImageView.image = images.fetchImageWithKey(key: scheduledPerformers[aircraftDescription].image as NSString)
        }
        else if(receivingPage == "Statics"){
           myAircraftImageView.image = images.fetchStaticImageByAirshowIndex(staticIndex: aircraftDescription, airshowIndex: selectedAirshowIndex)
        }
        myAircraftImageView.contentMode = UIViewContentMode.scaleAspectFit
        self.view.addSubview(myAircraftImageView)
        
        //sets the frame of the textview to the screen
        theDescription = UITextView(frame: CGRect(x: 0, y: imageHeight + displayHeight , width: self.view.frame.width, height: self.view.frame.height - (imageHeight + displayHeight)))
        //set the text, font type, size & color
        theDescription.font = UIFont.systemFont(ofSize: 20)
        theDescription.textAlignment = .left
        theDescription.backgroundColor = .gray
        theDescription.textColor = .white
        theDescription.isEditable = false
        theDescription.isScrollEnabled = true
        if(receivingPage == "Performers"){
            theDescription.text = scheduledPerformers[aircraftDescription].description
        }
        else if(receivingPage == "Statics"){
            theDescription.text = InfoStore.getDatabase().airshows[selectedAirshowIndex]!.statics[aircraftDescription]?.description
        }

        
        //adds textview to the page
        self.view.addSubview(theDescription)
    }
    @objc func goBack(_ sender: Any) {
        if(receivingPage == "Performers"){
        self.performSegue(withIdentifier: "AircraftDescriptionstoPerformers", sender: self)
        }
        else if(receivingPage == "Statics"){

            self.performSegue(withIdentifier: "DescriptionToStatic", sender: self)
        }
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
