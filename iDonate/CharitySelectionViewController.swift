//
//  CharitySelectionViewController.swift
//  iDonate
//
//  Created by Ronak Shah on 10/22/16.
//  Copyright © 2016 Ronak Shah. All rights reserved.
//

import UIKit

class CharitySelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var charities: NSMutableArray = NSMutableArray()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loading recent purchases
        
        //TODO: Implement Recent Loading
        charities = DataManager.getArray(key: "charities")
        //temp: adds fake recent so we can test UI
        //let p = Charity(address: Address(name: "Make a Wish Foundation", a1: "4742 North 24th Street", a2: "Suite 400", state: "AZ", city: "Phoenix", country: "United States", zip: "85016", number: ""))
        //charities.add(p)
        
        if (!UserDefaults.standard.bool(forKey: "launchedBefore")) {
            let c1 = Charity(address: Address(name: "Make a Wish America", a1: "4742 N. 24th St.", a2: "Suite 400", state: "AZ", city: "Phoenix", country: "US", zip: "85016", number: "602-279-9474"))
            let c2 = Charity(address: Address(name: "American Red Cross", a1: "American Red Cross", a2: "PO Box 37839", state: "IA", city: "Boone", country: "US", zip: "50037-0839", number: "1-800-733-2767"))
            let c3 = Charity(address: Address(name: "Stand Up For Kids", a1: "83 Walton Street", a2: "Suite 500", state: "GA", city: "Atlanta", country: "US", zip: "30303", number: "8003654543"))
            let c4 = Charity(address: Address(name: "Home Front Military Charity (San Diego)", a1: "2115 Park Blvd", a2: "", state: "CA", city: "San Diego", country: "US", zip: "92101", number: "7603921551"))
            charities.add(c4)
            charities.add(c1)
            charities.add(c2)
            charities.add(c3)
            DataManager.saveArray(array: charities, key: "charities")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        //base charities for the user to get started
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        charities = DataManager.getArray(key: "charities")
        //temp: adds fake recent so we can test UI
        //let p = Charity(address: Address(name: "Make a Wish Foundation", a1: "4742 North 24th Street", a2: "Suite 400", state: "AZ", city: "Phoenix", country: "United States", zip: "85016", number: ""))
        //charities.add(p)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charities.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            return tableView.dequeueReusableCell(withIdentifier: "addCell")!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "charityCell") as! CharityTableViewCell
        
        let charity = charities[indexPath.row - 1] as! Charity
        
        cell.loadCharity(c: charity)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataManager.saveObject(object: charities[indexPath.row - 1] as AnyObject, key: "selectedCharity")
        //making my life easier by putting the object in storage until we get to the selection vc
        
        let vc: CameraViewController = self.storyboard!.instantiateViewController(withIdentifier: "cameraVC") as! CameraViewController
        self.show(vc as UIViewController, sender: vc)

    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.row != 0) {
            return true
        }
        return false
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("Row: \(indexPath.row - 1)")
        
        self.charities.removeObject(at: indexPath.row - 1)
        
        DataManager.saveArray(array: self.charities, key: "charities")
        //                                                 charities
        tableView.reloadData()
    }

    
}
