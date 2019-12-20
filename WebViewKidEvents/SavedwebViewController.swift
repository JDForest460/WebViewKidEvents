//
//  SavedwebViewController.swift
//  WebViewKidEvents
//
//  Created by Jiade Lin on 12/20/19.
//  Copyright © 2019 Jiade Lin. All rights reserved.
//

import UIKit
import WebKit
class SavedwebViewController: UIViewController {
    @IBOutlet weak var webbox: WKWebView!
    var url: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string:url ?? "https://developer.apple.com/documentation/webkit/wkwebview")
        let myRequest = URLRequest(url: myURL!)
        webbox.load(myRequest)
        // Do any additional setup after loading the view.
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
