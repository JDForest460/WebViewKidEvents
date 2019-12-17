//
//  SavedViewController.swift
//  WebViewKidEvents
//
//  Created by Jiade Lin on 12/16/19.
//  Copyright © 2019 Jiade Lin. All rights reserved.
//

import UIKit
import Alamofire
class SavedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var mytableview: UITableView!
    
    var rowcount = 0
    var myid:[Int] = []
    var mytitle:[String] = []
    var myurl:[String] = []
    
    let myRefreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()

        doapicall()
        
        mytableview.dataSource = self
        mytableview.delegate = self
    
        
        myRefreshControl.addTarget(self, action: #selector(doapicall), for: .valueChanged)
        mytableview.refreshControl = myRefreshControl
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
        
        return cell
    }
    @objc func doapicall(){
        let url = "http://localhost:8080/tomcatserver1/usersaved?id=1"
                   AF.request(url).responseJSON { response in
                              switch response.result{
                              case.success:
                                  self.extractUserData(jsonResponse: response)
                              case.failure(let error):
                                  print(error)
                              }
                          }
       
        self.mytableview.reloadData()
        self.myRefreshControl.endRefreshing()
        
    }
    func extractUserData(jsonResponse: AFDataResponse<Any>) {
        guard let jsonData = jsonResponse.data else {
            print("Unable to get data from response  ")
            return
        }
        do {
            let usersData = try JSONDecoder().decode(UsersModel.self, from: jsonData)
          
            rowcount = usersData.usersaved.count
            

            for i in 0..<rowcount{
                
                myid.append(usersData.usersaved[i].savedid)
                mytitle.append(usersData.usersaved[i].title)
                myurl.append( usersData.usersaved[i].url)
               
               // print(mytitle[i])
                //print("\"id\" record: \(i), user \"id\": \(myId), \"title\": \(mytitle),\"url\": \(myurl)")
            }
    
            mytableview.reloadData()
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
