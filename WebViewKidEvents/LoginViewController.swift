//
//  LoginViewController.swift
//  WebViewKidEvents
//
//  Created by Jiade Lin on 12/19/19.
//  Copyright © 2019 Jiade Lin. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    @IBOutlet weak var usernamebox: UITextField!
    @IBOutlet weak var passwordbox: UITextField!
    @IBOutlet weak var loginbutton: UIButton!
    var backtype = ""
    var storeid = ""
    var ec2 = "ec2-18-188-247-38.us-east-2.compute.amazonaws.com"
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func dologin(_ sender: Any) {
        //http://localhost:8080/tomcatserver1/login?username=test2&password=p2
       // var apiurl = "http://ec2-18-188-247-38.us-east-2.compute.amazonaws.com:8080/tomcatserver1/login?username="
       var apiurl = "http://localhost:8080/tomcatserver1/login?username="
       
        apiurl.append(usernamebox.text!)
        apiurl.append("&password=")
        apiurl.append(passwordbox.text!)
        //print(apiurl)
       // let url = "http://localhost:8080/tomcatserver1/usersaved?id=1"
        AF.request(apiurl).responseJSON { response in
            switch response.result{
            case.success:
               // print(response)
                
                 guard let jsonData = response.data else {
                           print("Unable to get data from response  ")
                           return
                       }
                       do {
                        let usersData = try JSONDecoder().decode(BackModel.self, from: jsonData)
                        //print(usersData.back)
                        self.backtype = usersData.back
                        self.storeid = usersData.id
                        if(self.backtype == "Login success"){
                           // print(usersData.back)
                           // print(self.storeid)
                            let defaults = UserDefaults.standard
                            defaults.set(self.storeid, forKey: "userid")
                            
                            
                            
                            self.performSegue(withIdentifier: "loginsegue", sender:"loginsegue" )
                        }else{
                            //print(usersData.back)
                            let alertController = UIAlertController(title: "Login Fail", message: usersData.back, preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                                       action in
                                   })
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                       } catch {
                           print("Error: Unable to map jsonData to BackModel  ")
                       }
               
                
            case.failure(let error):
                print(error)
            }
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
