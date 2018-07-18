//
//  Settings.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 2/21/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseMessaging

protocol SettingsProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class Settings: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    var pickerData: [String] = [String]()
    
    var basePassing:String = ""
    
    var notificationLabel: UILabel?
    
    var pickerNewBase: UIPickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        //navigation bar
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.10))
        //let navHeight: CGFloat = self.view.frame.height * 0.10
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "SETTINGS")
        let backButton = UIBarButtonItem(title: "<Back", style: .plain, target: nil, action: #selector (actionClick))
        
        navItem.leftBarButtonItem = backButton;
        navBar.setItems([navItem], animated: false)

        //new base label
        let newBaseLabel: UILabel!
        newBaseLabel = UILabel(frame: CGRect(x:0, y:self.view.frame.height * 0.3, width: self.view.frame.width, height:21))
        newBaseLabel.text = "Base Preference"
        newBaseLabel.font = newBaseLabel.font.withSize(20)
        newBaseLabel.textAlignment = .center
        newBaseLabel.backgroundColor = .gray
        newBaseLabel.textColor = .white
        self.view.addSubview(newBaseLabel)
        
        //new base picker
        let heightStarter: CGFloat = self.view.frame.height * 0.30
        pickerNewBase = UIPickerView(frame: CGRect(x:0, y:heightStarter + 21, width: self.view.frame.width, height:heightStarter))
        self.view.addSubview(pickerNewBase!)
        
        pickerData = InfoStore.getDatabase().AirshowNames()
        
        pickerNewBase?.delegate = self
        pickerNewBase?.dataSource = self
        
        pickerNewBase?.backgroundColor = .gray
        
        createButton()
        

    }
    func createButton () {
        let newBaseButton = UIButton();
        newBaseButton.layer.cornerRadius = 5
        newBaseButton.setTitle("OK", for: .normal)
        newBaseButton.setTitleColor(UIColor.blue, for: .normal)
        newBaseButton.frame = CGRect(x: self.view.frame.width  * 0.4,y: self.view.frame.height * 0.65, width: self.view.frame.width  * 0.25 , height: 25)
        newBaseButton.backgroundColor = UIColor.white
        
        self.view.addSubview(newBaseButton)
        newBaseButton.addTarget(self, action: #selector (chooseNewBase), for: .touchUpInside)
    }
    @objc func chooseNewBase(sender: UIButton!){
        //button code
        choseNewBase()
        self.performSegue(withIdentifier: "SettingsToAirshow", sender: self)
    }
    //changes the view to the airshow page
    @objc func actionClick(sender:UIBarButtonSystemItem){
        self.performSegue(withIdentifier: "SettingsToAirshow", sender: self)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //The number of columns
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        //return 1
        return pickerView.numberOfComponents
    }
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row] as String
    }
    //Set picker text color to white
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 15.0)!,NSAttributedStringKey.foregroundColor:UIColor.white])
        return myTitle
    }
    @objc func choseNewBase()
    {
        PListConnection.saveMyBase(value: pickerData[pickerNewBase!.selectedRow(inComponent: 0)])
        let newTopic = pickerData[pickerNewBase!.selectedRow(inComponent: 0)]
        Messaging.messaging().subscribe(toTopic: newTopic)
        print("Subscribed to \(newTopic) topic")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
