//
//  SocialMedia.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 2/13/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import UIKit

class  SocialMedia: UIViewController, UIGestureRecognizerDelegate{
   
    //Creates an array to populate the table
    private let socialPages: NSArray = ["WEBSITE","FACEBOOK","TWITTER"]
    //tableview variable
    private var imageTwitter: UIImageView!
    private var imageFacebook: UIImageView!
    private var imageWebsite: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //adds the navigation bar to the view controller
        self.view.backgroundColor = .gray
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navHeight: CGFloat = self.view.frame.height * 0.10
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: navHeight))
        self.view.addSubview(navBar)
        //sets the title on the navigation bar
        let navItem = UINavigationItem(title: "SOCIAL MEDIA")
        let backButton = UIBarButtonItem(title: "<Back", style: .plain, target: nil, action: #selector (actionClick))
        //Adds a button to the navigation bar
        navItem.leftBarButtonItem = backButton;
        navBar.setItems([navItem], animated: false);
        
        let imageWidth: CGFloat = self.view.frame.width * 0.30
        let imageHeight  = imageWidth
        
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(Attractions.handleTap))
        gestureTap.numberOfTapsRequired = 1
        gestureTap.numberOfTouchesRequired = 1
        gestureTap.delegate = self
        
        //add image and corresponding label to page
        imageTwitter = UIImageView(frame: CGRect(x:0, y: self.view.frame.height * 0.15, width: imageWidth, height: imageHeight))
        imageTwitter.image = UIImage(named: "USAFLogo")
        let labelTwitter = UILabel(frame: CGRect(x: imageWidth, y: self.view.frame.height * 0.15, width: self.view.frame.width - imageWidth, height: imageHeight))
        labelTwitter.textAlignment = .center
        labelTwitter.text = "TWITTER"
        labelTwitter.textColor = .white
        labelTwitter.backgroundColor = .gray
        self.view.addSubview(labelTwitter)
        self.view.addSubview(imageTwitter)
        //add gesture recognizer to the twitter image
        imageTwitter.isUserInteractionEnabled = true
        labelTwitter.addGestureRecognizer(gestureTap)
        imageTwitter.addGestureRecognizer(gestureTap)
        
        //add image and corresponding label to page
        imageFacebook = UIImageView(frame: CGRect(x:0, y: self.view.frame.height * 0.40, width: imageWidth, height: imageHeight))
        imageFacebook.image = UIImage(named: "USAFLogo")
        let labelFacebook = UILabel(frame: CGRect(x: imageWidth, y: self.view.frame.height * 0.40, width: self.view.frame.width - imageWidth, height: imageHeight))
        labelFacebook.textAlignment = .center
        labelFacebook.text = "FACEBOOK"
        labelFacebook.textColor = .white
        labelFacebook.backgroundColor = .gray
        self.view.addSubview(labelFacebook)
        self.view.addSubview(imageFacebook)
         //add gesture recognizer to the facebook image
        imageFacebook.isUserInteractionEnabled = true
        imageFacebook.addGestureRecognizer(gestureTap)
        labelFacebook.addGestureRecognizer(gestureTap)
        
        //add image and corresponding label to page
        imageWebsite = UIImageView(frame: CGRect(x:0, y: self.view.frame.height * 0.65, width: imageWidth, height: imageHeight))
        imageWebsite.image = UIImage(named: "USAFLogo")
        let labelWebsite = UILabel(frame: CGRect(x: imageWidth, y: self.view.frame.height * 0.65, width: self.view.frame.width - imageWidth, height: imageHeight))
        labelWebsite.textAlignment = .center
        labelWebsite.text = "WEBSITE"
        labelWebsite.textColor = .white
        labelWebsite.backgroundColor = .gray
        self.view.addSubview(labelWebsite)
        self.view.addSubview(imageWebsite)
         //add gesture recognizer to the website image
        imageWebsite.isUserInteractionEnabled = true
        imageWebsite.addGestureRecognizer(gestureTap)
        labelWebsite.addGestureRecognizer(gestureTap)
    
    }
    //tap method
    @objc func handleTap(sender: UITapGestureRecognizer) {
        //maximizes the image to full screen
        if sender == imageTwitter {
            let twitterLink = (InfoStore.database?.airshows[0]?.twitterLink)!
            if let urlTwitter = NSURL(string: twitterLink){UIApplication.shared.openURL(urlTwitter as URL)}
            
        }
        else if sender == imageFacebook{
            let facebookLink = (InfoStore.database?.airshows[0]?.facebookLink)!
            if let urlFacebook = NSURL(string: facebookLink){UIApplication.shared.openURL(urlFacebook as URL)}

        }
        else if sender == imageWebsite{
            let websiteLink = (InfoStore.database?.airshows[0]?.websiteLink)!
            if let urlWebsite = NSURL(string:websiteLink){UIApplication.shared.openURL(urlWebsite as URL)}

        }
    }
    //Code for the back button
    //takes the user back to the previous page
    @objc func actionClick(sender:UIBarButtonSystemItem){
        self.performSegue(withIdentifier: "SocialToAirshow", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
