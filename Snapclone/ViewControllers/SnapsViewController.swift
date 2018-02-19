//
//  SnapsViewController.swift
//  Snapclone
//
//  Created by Juan Tenezaca on 2/17/18.
//  Copyright © 2018 Juan Tenezaca. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var snaps : [snap] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

    Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childAdded) {(snapshot) in
            print(snapshot)
            let value  = snapshot.value as? NSDictionary
            
            let Snap = snap()
            Snap.imageURL = value?["imageURL"] as! String
            Snap.from = value?["from"] as! String
            Snap.descrip = value?["description"] as! String
            Snap.key = snapshot.key
            Snap.uuid = value?["uuid"] as! String
        
            self.snaps.append(Snap)
            self.tableView.reloadData()
        }
        
        Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childRemoved) {(snapshot) in
            print(snapshot)
            
            var index = 0
            
            for snap in self.snaps{
                if snap.key == snapshot.key{
                    self.snaps.remove(at: index)
                }
                index += 1
            }
            self.tableView.reloadData()
        }
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if snaps.count == 0{
            return 1
        } else {
        return snaps.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  UITableViewCell()
        if snaps.count == 0{
            cell.textLabel?.text = "You have no snaps 😔"
        }else {
        let snap = snaps[indexPath.row]
        
        cell.textLabel?.text = snap.from
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]

        performSegue(withIdentifier: "viewsnapsegue", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewsnapsegue"{
        
        let nextVC = segue.destination as! ViewSnapViewController
        
        nextVC.Snap = sender as! snap
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
