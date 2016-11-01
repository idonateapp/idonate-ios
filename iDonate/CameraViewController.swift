//
//  CameraViewController.swift
//  iDonate
//
//  Created by Ronak Shah on 10/17/16.
//  Copyright © 2016 Ronak Shah. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, BarcodeScannerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet fileprivate weak var barcodeScannerView: BarcodeScannerView!
    var purchases: NSMutableArray = NSMutableArray()
    var bug = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barcodeScannerView.delegate = self
        
        //loading recent purchases
        
        purchases = DataManager.getArray(key: "purchases")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func didRecognizeBarcode(_ barcode: String) {
        buy(b: barcode)
        //ok now we have the code
        //now we change views
        
    }
    
    func buy(b: String) {
        if (!bug) {
            let vc: SelectionViewController = self.storyboard!.instantiateViewController(withIdentifier: "selectVC") as! SelectionViewController
            vc.barcode = b
            self.show(vc as UIViewController, sender: vc)
            bug = true
        }
    }
    
    //MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentPurchaseCell") as! RecentPurchaseTableViewCell
        
        let recentProduct = purchases[indexPath.row] as! Product
        
        cell.loadProduct(p: recentProduct)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = purchases[indexPath.row] as! Product
        buy(b: product.barcode)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.purchases.removeObject(at: indexPath.row)
        DataManager.saveArray(array: self.purchases, key: "purchases")
        tableView.reloadData()
    }
}

