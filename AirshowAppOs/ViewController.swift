//
//  ViewController.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 11/13/17.
//  Copyright © 2017 Dev Lab Mac 2. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging

class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
    //Plist variables
    let myBaseKey = "myBase"
    var myBaseValue = ""
    //Button Click code
    @IBOutlet weak var btnSplashPage: UIButton!
    @IBOutlet weak var labelError: UILabel!
    // Variables for the picker view
    @IBOutlet weak var pickerBases: UIPickerView!
    var pickerBasesData: [String] = [String]()
    var valueSelected: String?

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //Connect()
        self.view.backgroundColor = .gray
        self.btnSplashPage.backgroundColor = .white

        
        //Connect Data
        pickerBases.delegate = self
        pickerBases.dataSource = self
        pickerBases.backgroundColor = .gray
        
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
        InfoStore.setDatabase(databaseIn: airshowData!)
    }
    @IBAction func buttonClick(_ sender: Any?) {
        if pickerBases.selectedRow(inComponent: 0) == 0{
        }
        else{
            let selected = pickerBases.selectedRow(inComponent: 0)
            PListConnection.saveMyBase(value: InfoStore.getDatabase().airshows[selected - 1]!.name)
            self.performSegue(withIdentifier: "ToAirshowTable", sender: self)
        }
    }
    override func viewDidAppear(_ animated: Bool)
    {
        if (InfoStore.getDatabase().AirshowNames().contains(PListConnection.loadMyBase())){
            
            self.performSegue(withIdentifier: "ToAirshowTable", sender: self)
        }
    }
    override func viewWillAppear(_ animated: Bool)
    {
        Connect()
        pickerBasesData = (airshowData?.AirshowNames())!
        pickerBasesData.insert("Choose An Airshow", at: 0)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is AirshowTable
        {
            //if a base is not already selected the chosen base will be saved to the plist file
            if myBaseValue == "Hello"
            {
                //saves the base to the plist
                //saveData(value: "Hello")
                // [START subscribe_topic]
                Messaging.messaging().subscribe(toTopic: valueSelected!)
                print("Subscribed to \(valueSelected!) topic")
                // [END subscribe_topic]
                PListConnection.saveMyBase(value: valueSelected!)
            }
        }
    }
    //The number of columns
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        //return 1
        return pickerView.numberOfComponents
    }
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerBasesData.count
    }
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerBasesData[row] as String
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // use the row to get the selected row from the picker view
        // using the row extract the value from your datasource (array[row])
         valueSelected = pickerBasesData[row]
    }
    //Set picker text color to white
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerBasesData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 15.0)!,NSAttributedStringKey.foregroundColor:UIColor.white])
        return myTitle
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //reads the information from the plist
}
