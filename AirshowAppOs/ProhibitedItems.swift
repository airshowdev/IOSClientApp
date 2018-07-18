//
//  ProhibitedItems.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 2/20/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import UIKit

class  ProhibitedItems: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        //adds the navigation bar to the view controller
        self.view.backgroundColor = .gray
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navHeight: CGFloat = self.view.frame.height * 0.10
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: navHeight))
        self.view.addSubview(navBar)
        //sets the title on the navigation bar
        let navItem = UINavigationItem(title: "PROHIBITED ITEMS")
        let backButton = UIBarButtonItem(title: "<Back", style: .plain, target: nil, action: #selector (actionClick))
        //Adds a button to the navigation bar
        navItem.leftBarButtonItem = backButton;
        navBar.setItems([navItem], animated: false);
        
        //creates the textview for the page
        var bannedItems = UITextView()
        //sets the frame of the textview to the screen
        bannedItems = UITextView(frame: CGRect(x: 0, y:barHeight + navHeight , width: self.view.frame.width, height: self.view.frame.height - navHeight))
        //set the text, font type, size & color
        bannedItems.font = UIFont.systemFont(ofSize: 20)
        bannedItems.textAlignment = .natural
        bannedItems.backgroundColor = .gray
        bannedItems.textColor = .white
        bannedItems.isEditable = false
        bannedItems.isScrollEnabled = true
        bannedItems.text = "Items prohibited include \n -Weapons such as pistols, rifles, switch blades, mace, pepper spray, personal tasers/stun guns, ammunition \n -Drugs, drug paraphernalia, open containers of alcoholic beverages \n -Pets (exception: animals assisting handicapped will be allowed)\n -Grills, fireworks, canopies, tents, coolers, large lawn chairs (exception: small folding camping chairs) \n -Backpacks, briefcases, large bags or packages (exception: diaper bags, small purses, small camera cases and fanny packs) \n -Hoverboards and drones"
        //adds textview to the page
        self.view.addSubview(bannedItems)
        
        
        
    }
    //Code for the back button
    //takes the user back to the previous page
    @objc func actionClick(sender:UIBarButtonSystemItem){
        self.performSegue(withIdentifier: "ProhibitedToAirshow", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
