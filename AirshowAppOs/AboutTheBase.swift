//
//  AboutTheBase.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 2/12/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import UIKit

class  AboutTheBase: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        //adds the navigation bar to the view controller
        self.view.backgroundColor = .gray
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navHeight: CGFloat = self.view.frame.height * 0.10
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: navHeight))
        self.view.addSubview(navBar)
        //sets the title on the navigation bar
        let titled = "About " + (InfoStore.database?.airshows[0]?.base)!
        //let navItem = UINavigationItem(title: "ABOUT THE BASE")
        let navItem = UINavigationItem(title: titled)
        let backButton = UIBarButtonItem(title: "<Back", style: .plain, target: nil, action: #selector (actionClick))
        //Adds a button to the navigation bar
        navItem.leftBarButtonItem = backButton;
        navBar.setItems([navItem], animated: false);
        
        //creates the textview for the page
        var baseInfo = UITextView()
        //sets the frame of the textview to the screen
        baseInfo = UITextView(frame: CGRect(x: 0, y:barHeight + navHeight , width: self.view.frame.width, height: self.view.frame.height - navHeight))
        //set the text, font type, size & color
        baseInfo.font = UIFont.systemFont(ofSize: 20)
        baseInfo.textAlignment = .justified
        baseInfo.backgroundColor = .gray
        baseInfo.textColor = .white
        baseInfo.isEditable = false
        baseInfo.isScrollEnabled = true
       
         baseInfo.text = (InfoStore.database?.airshows[0]?.description)!
        //adds textview to the page
        self.view.addSubview(baseInfo)

        
        
    }
    //Code for the back button
    //takes the user back to the previous page
    @objc func actionClick(sender:UIBarButtonSystemItem){
        self.performSegue(withIdentifier: "AboutToAirshow", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
