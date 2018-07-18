//
//  NewSocialMedia.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 2/28/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import UIKit

class NewSocialMedia: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    var selectedAirshowIndex: Int = 0
    let socialMediaPages: NSArray = ["Facebook","Instagram","Twitter", "Website"]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        tableView.delegate = self
        tableView.dataSource = self

        
        self.view.backgroundColor = .gray
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return socialMediaPages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell2") as! Custom2TableViewCell
        
        cell.linkLabel.text = socialMediaPages[indexPath.row] as! String
        cell.linkLabel.textAlignment = .center
        cell.linkImage.image = UIImage(named: socialMediaPages[indexPath.row] as! String)
        cell.backgroundColor = .gray
        
        return cell
    }
    @IBAction func goBack(_ sender: Any) {
        self.performSegue(withIdentifier: "SocialToAirshow", sender: self)
    }
    //adjust the size of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / CGFloat(socialMediaPages.count)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(socialMediaPages[indexPath.row])")
        //takes the user to the map if parking is selected
        switch indexPath.row {
        case 0:
            let facebookLink = (InfoStore.database?.airshows[selectedAirshowIndex]?.facebookLink)!
            if let urlFacebook = NSURL(string: facebookLink){UIApplication.shared.open(urlFacebook as URL, options: [:], completionHandler: nil)}
        case 1:
            let instagramLink = (InfoStore.database?.airshows[selectedAirshowIndex]?.instagramLink)!
            if let urlInstagram = NSURL(string:instagramLink){UIApplication.shared.open(urlInstagram as URL, options: [:], completionHandler: nil)}
        case 2:
            let twitterLink = (InfoStore.database?.airshows[selectedAirshowIndex]?.twitterLink)!
            if let urlTwitter = NSURL(string: twitterLink){UIApplication.shared.open(urlTwitter as URL, options: [:], completionHandler: nil)}
        
        case 3:
            let websiteLink = (InfoStore.database?.airshows[selectedAirshowIndex]?.websiteLink)!
            if let urlWebsite = NSURL(string:websiteLink){UIApplication.shared.open(urlWebsite as URL, options: [:], completionHandler: nil)}
        default:
            let instagramLink = (InfoStore.database?.airshows[selectedAirshowIndex]?.instagramLink)!
            if let urlInstagram = NSURL(string:instagramLink){UIApplication.shared.open(urlInstagram as URL, options: [:], completionHandler: nil)}
    }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
