//
//  testViewController.swift
//  WebViewKidEvents
//
//  Created by Jiade Lin on 12/9/19.
//  Copyright © 2019 Jiade Lin. All rights reserved.
//

import UIKit
import Alamofire
class testViewController: UIViewController {

    @IBOutlet weak var testapicall: UIButton!
    @IBOutlet weak var namelabel: UILabel!

    
    @IBOutlet weak var urllabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadsaved()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        loadsaved()
    }
    func loadsaved(){
        let defaults = UserDefaults.standard
        let s1 = defaults.string(forKey: "SavedString")
        let s2 = defaults.string(forKey: "Savedurl")
        namelabel.text = s1
        urllabel.text = s2
    }

    @IBAction func dotestapicall(_ sender: Any) {
         let url = "http://localhost:8080/tomcatserver1/usersaved?id=1"
            AF.request(url).responseJSON { response in
                       switch response.result{
                       case.success:
                           self.extractUserData(jsonResponse: response)
                       case.failure(let error):
                           print(error)
                       }
                   }
    }
    
    /*
     let url = "http://localhost:8080/tomcatserver1/usersaved?id=1"
     AF.request(url).responseJSON { response in
                switch response.result{
                case.success:
                    self.extractUserData(jsonResponse: response)
                case.failure(let error):
                    print(error)
                }
            }
     */
    func extractUserData(jsonResponse: AFDataResponse<Any>) {
        guard let jsonData = jsonResponse.data else {
            print("Unable to get data from response  ")
            return
        }
        do {
            let usersData = try JSONDecoder().decode(UsersModel.self, from: jsonData)
            print(usersData.usersaved.count)
        /*
            for (i, saved) in usersData.usersaved.enumerated() {
                let myId = saved.savedid
                let mytitle = saved.title
                let myurl = saved.url
                print("\"id\" record: \(i), user \"id\": \(myId), \"title\": \(mytitle),\"url\": \(myurl)")
            }
         */
        } catch {
            print("Error: Unable to map jsonData to UsersModel  ")
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
