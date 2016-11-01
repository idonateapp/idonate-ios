//
//  SettingsViewController.swift
//  iDonate
//
//  Created by Ronak Shah on 10/30/16.
//  Copyright © 2016 Ronak Shah. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openSite(_ sender: UIButton) {
        switch sender.tag {
        case 0: //ronak shah
            openSite(site: "http://ronakshah.net")
            break
        case 1: //tushar chopra
            openSite(site: "http://tusharchopra.tk")
            break
        case 2: //why
            openSite(site: "https://idonateapp.github.io/story")
            break
        case 3: //source
            openSite(site: "https://idonateapp.github.io/source")
            break
        case 4: //feedback
            openSite(site: "https://idonateapp.github.io/index.html#footer")
            break
        case 5: //settings
            openSite(site: "https://idonateapp.github.io/settings")
            break
        default: break
            //do nothing
        }
    }
    
    func openSite(site: String) {
        UIApplication.shared.open(URL(string: site)!, options: [:], completionHandler: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
