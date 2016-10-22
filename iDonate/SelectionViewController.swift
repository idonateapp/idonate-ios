//
//  SelectionViewController.swift
//  iDonate
//
//  Created by Ronak Shah on 10/21/16.
//  Copyright © 2016 Ronak Shah. All rights reserved.
//

import UIKit
import WebKit

class SelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var webView: UIWebView!
    
    var barcode: String = "barcode+invalid"
    var addressList: [Address] = [Address]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
        // Do any additional setup after loading the view.
        
        //TODO: Implement User Defaults Charity Loading
        
        //temp fix: sample address list
        addressList = [Address(name: "Charity For Hope", addressLine1: "9450 Mira Mesa Blvd", addressLine2: "", state: "CA", city: "San Diego", country: "United States", zip: "92126", number: "(972) 896-5692")]
    
        //webview
        /*
        let configuration = WKWebViewConfiguration()
        let controller = WKUserContentController()
        
        let scriptSourceCode = "your javascript code here"
        let script = WKUserScript(source: scriptSourceCode, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
        controller.addUserScript(script)
        
        configuration.userContentController = controller
        */
    }

    override func viewDidAppear(_ animated: Bool) {
        print("interesting")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func loadWebView() {
        let site = "https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords=\(barcode)"
        webView.loadRequest(URLRequest(url: NSURL(string: site)! as URL))
        
    }
    
    //MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell") as! AddressTableViewCell
        let add = addressList[indexPath.row]
        cell.loadAddress(add: add)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = addressList[indexPath.row]
        
        
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
