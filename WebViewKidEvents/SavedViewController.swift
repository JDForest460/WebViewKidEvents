//
//  SavedViewController.swift
//  WebViewKidEvents
//
//  Created by Jiade Lin on 12/16/19.
//  Copyright © 2019 Jiade Lin. All rights reserved.
//

import UIKit
import Alamofire
class SavedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,MyCustomCellDelegator {
    func callSegueFromCell(myData: String) {
        senturl = myData
       // print(myData)
        self.performSegue(withIdentifier: "savedwebsegue", sender:"savedwebsegue" )
    }
    func callDeleteFromCell() {
       // print("delete")
        let alertController = UIAlertController(title: "", message: "This event is been deleted", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                   action in
               })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        
        doapicall()
    }
    
    
    @IBAction func searchbutton(_ sender: Any) {
    }
    
    @IBOutlet weak var mytableview: UITableView!
    var senturl = "url"
    var rowcount = 0
    var myid:[Int] = []
    var mytitle:[String] = []
    var myurl:[String] = []
    
    let myRefreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        mytableview.dataSource = self
        mytableview.delegate = self

        myRefreshControl.addTarget(self, action: #selector(doapicall), for: .valueChanged)
        mytableview.refreshControl = myRefreshControl
        
        doapicall()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rowcount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell") as! SavedCell
        cell.userid = myid[indexPath.row]
        cell.titlelabel.text = "Title: " + mytitle[indexPath.row]
        cell.urllabel.text = "Url: " + myurl[indexPath.row]
        cell.cellurl = myurl[indexPath.row]
        cell.delagete = self as! MyCustomCellDelegator
        return cell
    }


    @objc func doapicall(){
        
        //http://ec2-18-188-247-38.us-east-2.compute.amazonaws.com:8080/tomcatserver1/usersaved?id=1
        let defaults = UserDefaults.standard
        let localuserid = defaults.integer(forKey: "userid")
       // var url = "http://ec2-18-188-247-38.us-east-2.compute.amazonaws.com:8080/tomcatserver1/usersaved?id="
        var url = "http://localhost:8080/tomcatserver1/usersaved?id="
        
        url.append(String(localuserid))
                   AF.request(url).responseJSON { response in
                              switch response.result{
                              case.success:
                                  self.extractUserData(jsonResponse: response)
                                  self.mytableview.reloadData()
                                  self.myRefreshControl.endRefreshing()
                              case.failure(let error):
                                  print(error)
                              }
                          }
       
       
        
    }
    func extractUserData(jsonResponse: AFDataResponse<Any>) {
        guard let jsonData = jsonResponse.data else {
            print("Unable to get data from response  ")
            return
        }
        do {
            let usersData = try JSONDecoder().decode(UsersModel.self, from: jsonData)
          
            rowcount = usersData.usersaved.count
            myid = []
            mytitle = []
            myurl = []

            for i in 0..<rowcount{
               
                myid.append(usersData.usersaved[i].savedid)
                mytitle.append(usersData.usersaved[i].title)
                myurl.append( usersData.usersaved[i].url)
               
               
            }
    
        } catch {
            print("Error: Unable to map jsonData to UsersModel  ")
        }
    
    }
    @IBAction func dosearch(_ sender: Any) {
        
    }
    
    override func prepare(for segue:UIStoryboardSegue,sender:Any?){
        if let VC = segue.destination as? SavedwebViewController{
        VC.url = senturl
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
