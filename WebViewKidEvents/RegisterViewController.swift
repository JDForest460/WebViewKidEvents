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
    var backtype = ""
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
    @IBAction func doregister(_ sender: Any) {
        if(passwordbox.text == confirmbox.text){
            //print("register success")
            //http://localhost:8080/tomcatserver1/register?username=test1&password=p1
            //ec2-18-188-247-38.us-east-2.compute.amazonaws.com
            var apiurl = "http://ec2-18-188-247-38.us-east-2.compute.amazonaws.com:8080/tomcatserver1/register?username="
                   apiurl.append(usernamebox.text!)
                   apiurl.append("&password=")
                   apiurl.append(passwordbox.text!)
                   //print(apiurl)
                   AF.request(apiurl).responseJSON { response in
                            switch response.result{
                            case.success:
                               // print(response)
                                
                                 guard let jsonData = response.data else {
                                           print("Unable to get data from response  ")
                                           return
                                       }
                                       do {
                                        let usersData = try JSONDecoder().decode(registBackModel.self, from: jsonData)
                                        //print(usersData.back)
                                        self.backtype = usersData.back
                                        if(self.backtype == "register success"){
                                           // print(usersData.back)
                                           // print(self.storeid)
                                         let alertController = UIAlertController(title: "Register Success", message: usersData.back, preferredStyle: .alert)
                                           let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                                                      action in
                                                  })
                                           alertController.addAction(okAction)
                                           self.present(alertController, animated: true, completion: nil)
                                            
                                        }else{
                                            //print(usersData.back)
                                            let alertController = UIAlertController(title: "Username exist", message:"please change another usename", preferredStyle: .alert)
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
