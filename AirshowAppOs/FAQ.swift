//
//  FAQ.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 2/15/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import UIKit

class FAQ: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //question array
    private let airshowFAQ: NSArray = InfoStore.getDatabase().AirshowQuestions() as NSArray
    //table variable
    var questionsTable: UITableView!
    var questionPassing:String = ""
    var questionAnswer: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        //adds the navigation bar to the view
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navHeight: CGFloat = self.view.frame.height * 0.10
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: navHeight))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "FAQ")
        let backButton = UIBarButtonItem(title: "<Back", style: .plain, target: nil, action: #selector (actionClick))
        //Adds a button to the navigation bar
        navItem.leftBarButtonItem = backButton
        navBar.setItems([navItem], animated: false)
        
        //adds the table and cells to the view
        //let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        questionsTable = UITableView(frame: CGRect(x: 0, y: navHeight, width: displayWidth, height: displayHeight - navHeight))
        questionsTable.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        questionsTable.dataSource = self
        questionsTable.delegate = self
        questionsTable.backgroundColor = .gray
        self.view.addSubview(questionsTable)

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airshowFAQ.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(airshowFAQ[indexPath.row])"
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = .gray
        cell.textLabel!.textColor = .white
        return cell
    }
    //Code for the items in the table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(airshowFAQ[indexPath.row])")
        //takes the user to the map if parking is selected
        questionPassing = airshowFAQ[indexPath.row] as! String
        questionAnswer = indexPath.row
            self.performSegue(withIdentifier: "FaqToAnswer", sender: self)
        
    }
    //occurs befir the seque to pass information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is FAQAnwser
        {
            let vc = segue.destination as? FAQAnwser
            vc?.questionPassed = questionPassing
            vc?.theRightAnswer = questionAnswer
        }
    }
    
    @objc func actionClick(sender:UIBarButtonSystemItem){
        self.performSegue(withIdentifier: "FaqToAirshow", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
