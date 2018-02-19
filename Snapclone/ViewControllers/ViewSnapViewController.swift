//
//  ViewSnapViewController.swift
//  Snapclone
//
//  Created by Juan Tenezaca on 2/19/18.
//  Copyright © 2018 Juan Tenezaca. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var Snap = snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = Snap.descrip

        imageView.sd_setImage(with: URL(string:Snap.imageURL))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    
       Database.database().reference().child("Users").child((Auth.auth().currentUser?.uid)!).child("snaps").child(Snap.key).removeValue()
        
        Storage.storage().reference().child("images").child("\(Snap.uuid).jpeg").delete { (error) in
            print("Object deleted")
        }
    }
}
