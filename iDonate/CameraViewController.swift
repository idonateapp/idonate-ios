//
//  CameraViewController.swift
//  iDonate
//
//  Created by Ronak Shah on 10/17/16.
//  Copyright © 2016 Ronak Shah. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, BarcodeScannerViewDelegate {
    
    @IBOutlet fileprivate weak var barcodeScannerView: BarcodeScannerView!
    
    var bug = false
    override func viewDidLoad() {
        super.viewDidLoad()
        barcodeScannerView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func didRecognizeBarcode(_ barcode: String) {
        print("\n\n\nBarcode: \(barcode)\n\n\n")
        
        //ok now we have the code
        //now we change views
        if (!bug) {
            let vc: SelectionViewController = self.storyboard!.instantiateViewController(withIdentifier: "selectionVC") as! SelectionViewController
            vc.barcode = barcode
            self.show(vc as UIViewController, sender: vc)
            bug = true
        }
    }
    
    
}

