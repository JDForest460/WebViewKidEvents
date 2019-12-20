//
//  SavedCell.swift
//  WebViewKidEvents
//
//  Created by Jiade Lin on 12/16/19.
//  Copyright © 2019 Jiade Lin. All rights reserved.
//

import UIKit
import Alamofire
protocol MyCustomCellDelegator {
    func callSegueFromCell(myData: String)
}
class SavedCell: UITableViewCell {
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var urllabel: UILabel!
    @IBOutlet weak var detailbutton: UIButton!
    
    var userid = 0
    var delagete: MyCustomCellDelegator?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func dodelete(_ sender: Any) {
        print(userid)
        //http://localhost:8080/tomcatserver1/delete?saveid=39
        
        var apiurl = "http://ec2-18-188-247-38.us-east-2.compute.amazonaws.com:8080/tomcatserver1/delete?saveid="
        apiurl.append(String(userid))
        //print(apiurl)
        AF.request(apiurl).response { response in
            debugPrint(response)
        }
       
    }
    @IBAction func dodetail(_ sender: Any) {
        
        self.delagete!.callSegueFromCell(myData: "good")
        
    }
    
}
