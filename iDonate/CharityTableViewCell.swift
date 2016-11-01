//
//  CharityTableViewCell.swift
//  iDonate
//
//  Created by Ronak Shah on 10/21/16.
//  Copyright © 2016 Ronak Shah. All rights reserved.
//

import UIKit

class CharityTableViewCell: UITableViewCell {

    @IBOutlet weak var addressNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressCountryZipLabel: UILabel!
    var charity: Charity!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func loadCharity(c: Charity) {
        
        let a = c.address
        self.addressNameLabel.text! = a.name
        self.addressLabel.text! = "\(a.addressLine1) \(a.addressLine2)"
        self.addressCountryZipLabel.text! = "\(a.city) \(a.state)"
        self.addressCountryZipLabel.text! = "\(a.country) \(a.zip)"
        self.charity = c
    }
    
    
    
}
