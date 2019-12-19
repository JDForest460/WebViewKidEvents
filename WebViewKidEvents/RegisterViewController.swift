//
//  RegisterViewController.swift
//  WebViewKidEvents
//
//  Created by Jiade Lin on 12/19/19.
//  Copyright © 2019 Jiade Lin. All rights reserved.
//

import UIKit
import Alamofire
class RegisterViewController: UIViewController {
    @IBOutlet weak var usernamebox: UITextField!
    @IBOutlet weak var passwordbox: UITextField!
    @IBOutlet weak var confirmbox: UITextField!
    @IBOutlet weak var registerbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func doregister(_ sender: Any) {
        if(passwordbox.text == confirmbox.text){
            //print("register success")
            //http://localhost:8080/tomcatserver1/register?username=test1&password=p1
            var apiurl = "http://ec2-18-188-247-38.us-east-2.compute.amazonaws.com:8080/tomcatserver1/register?username="
                   apiurl.append(usernamebox.text!)
                   apiurl.append("&password=")
                   apiurl.append(passwordbox.text!)
                   //print(apiurl)
                   AF.request(apiurl).response { response in
                       debugPrint(response.result)
                   }
            
            
            let alertController = UIAlertController(title: "", message: "Your register is success", preferredStyle: .alert)
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
