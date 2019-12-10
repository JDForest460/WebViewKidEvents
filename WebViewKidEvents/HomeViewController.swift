//
//  HomeViewController.swift
//  WebViewKidEvents
//
//  Created by Jiade Lin on 12/9/19.
//  Copyright © 2019 Jiade Lin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var FindStorytimeButton: UIButton!
    @IBOutlet weak var FindPlaygroundButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func doFindStoryTime(_ sender: Any) {
        performSegue(withIdentifier: "findstorytimesegue", sender: "findstorytimesegue")
    }
    
    @IBAction func doFindplayground(_ sender: Any) {
        performSegue(withIdentifier: "findplaygroundsegue", sender: "findplaygroundsegue")
    }
    
    @IBAction func doFindToyStore(_ sender: Any) {
        performSegue(withIdentifier: "findtoystoresegue", sender: "findtoystoresegue")
    }
    @IBAction func doFindZoo(_ sender: Any) {
        performSegue(withIdentifier: "findzoosegue", sender: "findzoosegue")
    }
    
    override func prepare(for segue:UIStoryboardSegue,sender:Any?){
          if segue.identifier == "findstorytimesegue"{
              if let VC = segue.destination as? WebViewController{
                  VC.url = "https://www.nypl.org/events/calendar?keyword=storytime"
              }
          }
        if segue.identifier == "findplaygroundsegue"{
            if let VC = segue.destination as? WebViewController{
                VC.url = "https://www.google.com/maps/search/playground"
            }
        }
        if segue.identifier == "findtoystoresegue"{
            if let VC = segue.destination as? WebViewController{
                VC.url = "https://www.google.com/maps/search/toy+store"
            }
        }
        if segue.identifier == "findzoosegue"{
            if let VC = segue.destination as? WebViewController{
                VC.url = "https://www.google.com/maps/search/zoo"
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
