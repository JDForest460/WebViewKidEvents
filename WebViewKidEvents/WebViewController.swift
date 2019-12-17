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
        // Do any additional setup after loading the view.
    }
    @IBAction func doSave(_ sender: Any) {
        
        
        let currenturl = (MainWebview.url?.absoluteString)!
        var apiurl = "http://localhost:8080/tomcatserver1/saveurl?savetitle="
        apiurl.append(saveName.text!)
        apiurl.append("&saveurl=")
        apiurl.append(currenturl)
        apiurl.append("&saveuserid=1")
        //print(apiurl)
        AF.request(apiurl).response { response in
            debugPrint(response)
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
