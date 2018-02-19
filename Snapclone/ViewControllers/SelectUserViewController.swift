//
//  SelectUserViewController.swift
//  Snapclone
//
//  Created by Juan Tenezaca on 2/17/18.
//  Copyright © 2018 Juan Tenezaca. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SelectUserViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var users : [User] = []
    var imageURL = ""
    var descrip = "" // equal to description of users choice
    var uuid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.tableView.dataSource = self
       self.tableView.delegate = self
        
        Database.database().reference().child("Users").observe(DataEventType.childAdded) {(snapshot) in
            print(snapshot)
            let value  = snapshot.value as? NSDictionary
            
            let user = User()
            user.email = value?["email"] as! String
            user.uid = snapshot.key
            
            self.users.append(user)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell()
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let snap = ["from":Auth.auth().currentUser!.email, "description":descrip, "imageURL":imageURL, "uuid":uuid]

        Database.database().reference().child("Users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        
        navigationController!.popToRootViewController(animated: true)
    }
}
