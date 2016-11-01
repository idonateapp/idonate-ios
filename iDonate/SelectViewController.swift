//
//  SelectionViewController.swift
//  iDonate
//
//  Created by Ronak Shah on 10/21/16.
//  Copyright © 2016 Ronak Shah. All rights reserved.
//

import UIKit
import WebKit

class Select: UIViewController, WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate {
    
    
    @IBOutlet weak var tempView: UIView!
    var webView: WKWebView?
    var contentController = WKUserContentController();
    var webContent: NSString!
    var barcode: String = "barcode+invalid"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // append the userAgent and ensure it contains our browser detect regEx
        //let userAgent = UIWebView().stringByEvaluatingJavaScript(from: "navigator.userAgent")! + " iPad"
        //UserDefaults.standardUserDefaults().registerDefaults(["UserAgent" : userAgent])
        
        // add JS content controller
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        // instantiate the web view
        webView = WKWebView(frame: tempView.frame, configuration: config)
        webView!.navigationDelegate = self
        
        // customize sizing
        self.tempView.removeFromSuperview()
        webView!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView!)
        
        let leadingConstraint = NSLayoutConstraint(item: webView!, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: webView!, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: webView!, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: webView!, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        
        view.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        
        //webView.addConstraint(tempView.constraints)
        
        // open the URL for the app
        let urlPath = "https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords=\(barcode)"
        let url: URL = URL(string: urlPath)!
        let request = NSURLRequest(url: url)
        webView!.load(request as URLRequest)
        // Do any additional setup after loading the view.
        
        
        /*
         //now lets bring back the address
         let a = (DataManager.getObject(key: "selectedCharity") as! Charity).address
         
         //webview
         
         let configuration = WKWebViewConfiguration()
         let controller = WKUserContentController()
         
         let scriptSourceCode = "function doWork(){parse(\"\(a.name)\",\"\(a.addressLine1)\",\"\(a.addressLine2)\",\"\(a.city)\",\"\(a.state)\",\"\(a.zip)\",\"\",\"\(a.country)\"),repeater=setTimeout(doWork(),1e3)}function stuff(){document.getElementById(\"form\").style.display=t?\"none\":\"\",repeater2=setTimeout(stuff(),2e3)}function selectItemByValue(a,b){for(var c=0;c<a.options.length;c++)a.options[c].value==b&&(a.selectedIndex=c)}function parse(a,b,c,d,e,f,g,h){document.getElementById(\"enterAddressFullName\").value=a,document.getElementById(\"enterAddressAddressLine1\").value=b,document.getElementById(\"enterAddressAddressLine2\").value=c,document.getElementById(\"enterAddressCity\").value=d,document.getElementById(\"enterAddressStateOrRegion\").value=e,document.getElementById(\"enterAddressPostalCode\").value=f,document.getElementById(\"enterAddressPhoneNumber\").value=g;var i=document.getElementById(\"enterAddressCountryCode\");selectItemByValue(i,h)}var repeater;doWork();var repeater2,t=!1;stuff();"
         let script = WKUserScript(source: scriptSourceCode, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
         controller.addUserScript(script)
         
         configuration.userContentController = controller
         wb.evaluateJavaScript("") { (thing:Any?, error:Error?) in
         //alert user of problem
         //self.alert(title: "Amazon Error", msg: "Unfortunately, due to errors within Amazon, we are unable to autofill in your charity's address.", prompt: "I Understand")
         //self.alert(title: "Error (Debug)", msg: error.debugDescription, prompt: "WTF")
         self.loadWebView()
         
         }*/
        findProduct()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadAddress()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    func loadAddress() {
        webView!.evaluateJavaScript("alert('OMFG IT WORKS')", completionHandler: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func loadWebView() {
        //let site = "https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords=\(barcode)"
        //webView!.load(URLRequest(url: URL(string: site)!))
    }
    
    func alert(title: String, msg: String, prompt: String) {
        let alertController = UIAlertController(title: title, message:
            msg, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: prompt, style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
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
        var components = webContent.components(separatedBy: "data-truncate-by-character=\"false\" class=\"a-size-medium a-color-null s-inline  s-access-title  a-text-normal\">Kirkland")
        components = components[1].components(separatedBy: "</h2>")
        let productName = components[0]
        print(productName)
        
        let product =  Product(name: productName, barcode: barcode)
        let arr = DataManager.getArray(key: "purchases")
        arr.add(product)
        DataManager.saveArray(array: arr, key: "purchases")
    }
    
    //MARK: TableView Methods
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

