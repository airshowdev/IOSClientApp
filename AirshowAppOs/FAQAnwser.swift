//
//  FAQAnwser.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 2/21/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import Foundation
import UIKit

class FAQAnwser: UIViewController
{
    var questionPassed:String = ""
    var theRightAnswer:Int = 0

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        //adds the navigation bar to the view
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navHeight: CGFloat = self.view.frame.height * 0.10
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: navHeight))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "FAQ")
        //let navItem = UINavigationItem(title: questionPassed)
        let backButton = UIBarButtonItem(title: "<Back", style: .plain, target: nil, action: #selector (actionClick))
        //Adds a button to the navigation bar
        navItem.leftBarButtonItem = backButton
        navBar.setItems([navItem], animated: false)
        
        let displayWidth: CGFloat = self.view.frame.width
        let label = UILabel(frame: CGRect(x: 0, y: navHeight + barHeight, width: displayWidth, height: 25))
        label.textAlignment = .center
        label.text = questionPassed
        self.view.addSubview(label)
        
        //creates the textview for the page
        var theAnswer = UITextView()
        //sets the frame of the textview to the screen
        theAnswer = UITextView(frame: CGRect(x: 0, y: barHeight + navHeight + 25 , width: self.view.frame.width, height: self.view.frame.height - navHeight - barHeight))
        //set the text, font type, size & color
        theAnswer.font = UIFont.systemFont(ofSize: 20)
        theAnswer.textAlignment = .justified
        theAnswer.backgroundColor = .gray
        theAnswer.textColor = .white
        theAnswer.isEditable = false
        theAnswer.isScrollEnabled = true
        theAnswer.text = InfoStore.getDatabase().questions[theRightAnswer]?.answer
        //adds textview to the page
        self.view.addSubview(theAnswer)
    
    }
    
    @objc func actionClick(sender:UIBarButtonSystemItem){
        self.performSegue(withIdentifier: "AnswerToFAQ", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
