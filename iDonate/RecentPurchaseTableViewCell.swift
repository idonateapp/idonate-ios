//
//  RecentPurchaseTableViewCell.swift
//  iDonate
//
//  Created by Ronak Shah on 10/22/16.
//  Copyright © 2016 Ronak Shah. All rights reserved.
//

import UIKit

class RecentPurchaseTableViewCell: UITableViewCell {

    var product: Product! = nil
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var barcode: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadProduct(p: Product) {
        self.product = p
        productName.text! = p.name
        barcode.text! = p.barcode
    }

}
