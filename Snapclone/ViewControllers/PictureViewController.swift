//
//  PictureViewController.swift
//  Snapclone
//
//  Created by Juan Tenezaca on 2/17/18.
//  Copyright © 2018 Juan Tenezaca. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    var uuid = NSUUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false

       imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
    
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        
        nextButton.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {    
        imagePicker.sourceType = .savedPhotosAlbum // testing; currently have no IOS device. If you have an IOS device switch this
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        
        nextButton.isEnabled = false
        
        let imagesFolder = Storage.storage().reference().child("images")
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        
        imagesFolder.child("\(uuid).jpeg").putData(imageData, metadata: nil) { (MetaData, error) in
            print ("Attempting to upload picture")
            if error != nil {
                print("We have an error in PictureViewController:\(error)")
            } else {
                print(MetaData?.downloadURL())
                self.performSegue(withIdentifier: "selectUserSegue", sender: MetaData?.downloadURL()!.absoluteString)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let nextVC = segue.destination as! SelectUserViewController
       nextVC.imageURL = sender as! String
       nextVC.descrip = descriptionTextField.text!
       nextVC.uuid = uuid
    }
}
