//
//  AddressTableViewCell.swift
//  iDonate
//
//  Created by Ronak Shah on 10/21/16.
//  Copyright © 2016 Ronak Shah. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var addressNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressCityStateLabel: UILabel!
    @IBOutlet weak var addressCountryZipLabel: UILabel!
    var address: Address!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadAddress(add: Address) {
        self.addressNameLabel.text! = add.name
        self.addressLabel.text! = "\(add.addressLine1), \(add.addressLine2)"
        self.addressCityStateLabel.text! = "\(add.city) \(add.state)"
        self.addressCountryZipLabel.text! = "\(add.country) \(add.zip)"
        self.address = add

    }
}
