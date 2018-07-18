//
//  CustomTableViewCell.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 1/22/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var aircraftImage: UIImageView!
    @IBOutlet weak var aircraftLabel: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
