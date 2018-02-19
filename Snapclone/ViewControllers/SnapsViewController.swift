//
//  SnapsViewController.swift
//  Snapclone
//
//  Created by Juan Tenezaca on 2/17/18.
//  Copyright © 2018 Juan Tenezaca. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
