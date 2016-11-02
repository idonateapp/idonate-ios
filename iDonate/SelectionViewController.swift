

//
//  SelectViewController.swift
//  iDonate
//
//  Created by Ronak Shah on 10/30/16.
//  Copyright © 2016 Ronak Shah. All rights reserved.
//

import UIKit
import WebKit

class SelectionViewController: UIViewController {
    
    var barcode: String = "barcode+invalid"
    
    
    @IBOutlet weak var webView: UIWebView!
    //Web
    var webContent: NSString!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(URLRequest(url: URL(string: "https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords=\(barcode)")!))
        findProduct()
        
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(SelectionViewController.resetMem), userInfo: nil, repeats: true)
        
        timer.fire()
    }
    
    func resetMem() {
        URLCache.shared.removeAllCachedResponses()
    }
    override func viewDidAppear(_ animated: Bool) {
        _ = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(SelectionViewController.injectJS), userInfo: nil, repeats: true)
        
        
    }
    
    
    func injectJS() {
        let address = (DataManager.getObject(key: "selectedCharity") as! Charity).address
        let js = "function doWork(){parse(\"\(address.name)\",\"\(address.addressLine1)\",\"\(address.addressLine2)\",\"\(address.city)\",\"\(address.state)\",\"\(address.zip)\",\"\(address.number)\",\"\(address.country)\"),repeater=setTimeout(doWork(),1500)}function selectItemByValue(a,b){for(var c=0;c<a.options.length;c++)a.options[c].value==b&&(a.selectedIndex=c)}function parse(a,b,c,d,e,f,g,h){document.getElementById(\"enterAddressFullName\").value=a,document.getElementById(\"enterAddressAddressLine1\").value=b,document.getElementById(\"enterAddressAddressLine2\").value=c,document.getElementById(\"enterAddressCity\").value=d,document.getElementById(\"enterAddressStateOrRegion\").value=e,document.getElementById(\"enterAddressPostalCode\").value=f,document.getElementById(\"enterAddressPhoneNumber\").value=g;var i=document.getElementById(\"enterAddressCountryCode\");selectItemByValue(i,h)}var repeater;doWork();"
        
        //let js = "function doWork(){parse(\"\(address.name)\",\"\(address.addressLine1)\",\"\(address.addressLine2)\",\"\(address.city)\",\"\(address.state)\",\"\(address.zip)\",\"\(address.number)\",\"\(address.country)\"),repeater=setTimeout(doWork(),100)}function stuff(){document.getElementById(\"form\").style.display=t?\"none\":\"\",repeater2=setTimeout(stuff(),2e3)}function selectItemByValue(a,b){for(var c=0;c<a.options.length;c++)a.options[c].value==b&&(a.selectedIndex=c)}function parse(a,b,c,d,e,f,g,h){document.getElementById(\"enterAddressFullName\").value=a,document.getElementById(\"enterAddressAddressLine1\").value=b,document.getElementById(\"enterAddressAddressLine2\").value=c,document.getElementById(\"enterAddressCity\").value=d,document.getElementById(\"enterAddressStateOrRegion\").value=e,document.getElementById(\"enterAddressPostalCode\").value=f,document.getElementById(\"enterAddressPhoneNumber\").value=g;var i=document.getElementById(\"enterAddressCountryCode\");selectItemByValue(i,h)}var repeater;doWork();var repeater2,t=!1;stuff()"
        webView.stringByEvaluatingJavaScript(from: js)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func findProduct() {
        
        let wrappedUrl = NSURL(string: "https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords=\(barcode)")
        
        if let url = wrappedUrl {
            let task = URLSession.shared.dataTask(with: url as URL) { (data, response, error) in //those three vars will be returned from the method
                
                //code here will happen when the task is completed
                if let urlContent = data {
                    
                    self.webContent = NSString(data: urlContent, encoding: String.Encoding.utf8.rawValue)
                    self.parseWebContent()
                    //print(self.webContent)
                }
                else {
                    //show error
                }
            }
            task.resume()
        }
        else {
            print("404 Page Not Found")
        }
        
    }
    
    func parseWebContent() {
        var components = webContent.components(separatedBy: "data-attribute=")
        if (components.count <= 2) {}
        else {
            components = components[1].components(separatedBy: "data-max-rows=\"0\"")
            let productName = components[0].replacingOccurrences(of: "\"", with: "")
            print(productName)
            
            var add = true
            let arr = DataManager.getArray(key: "purchases")
            if (arr.count == 0) {
                return
            }
            for index in (0...arr.count-1) {
                let p = arr.object(at: index) as! Product
                if (p.barcode == barcode) {
                    add = false
                }
            }
            if (add) {
                let product =  Product(name: productName, barcode: barcode)
                arr.add(product)
                DataManager.saveArray(array: arr, key: "purchases")
            }
        }
    }
}

