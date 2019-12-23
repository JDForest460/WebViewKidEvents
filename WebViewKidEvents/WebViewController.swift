//
//  WebViewController.swift
//  WebViewKidEvents
//
//  Created by Jiade Lin on 12/9/19.
//  Copyright © 2019 Jiade Lin. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
class WebViewController: UIViewController {
    @IBOutlet weak var MainWebview: WKWebView!
    @IBOutlet weak var saveName: UITextField!
    @IBOutlet weak var save: UIButton!
    var url: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string:url ?? "https://developer.apple.com/documentation/webkit/wkwebview")
        let myRequest = URLRequest(url: myURL!)
        MainWebview.load(myRequest)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func doSave(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        let localuserid = defaults.integer(forKey: "userid")
        
        let currenturl = (MainWebview.url?.absoluteString)!
        //var apiurl = "http://ec2-18-188-247-38.us-east-2.compute.amazonaws.com:8080/tomcatserver1/saveurl?savetitle="
        var apiurl = "http://localhost:8080/tomcatserver1/saveurl?savetitle="
        apiurl.append(saveName.text!)
        apiurl.append("&saveurl=")
        apiurl.append(currenturl)
        apiurl.append("&saveuserid=")
        apiurl.append(String(localuserid))
       // print(apiurl)
        
        AF.request(apiurl).response { response in
            debugPrint(response)
        }
        if(true){
            let alertController = UIAlertController(title: "", message: "This event is been saved", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                       action in
                   })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
 
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
