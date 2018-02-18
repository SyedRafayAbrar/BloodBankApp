//
//  CreatingDonorViewController.swift
//  BloodBankApp
//
//  Created by Syed  Rafay on 15/02/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase


class CreatingDonorViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet var address: UITextField!
    var imagePicker: UIImagePickerController!
    var imageSelected = false
var ref: DatabaseReference!
    var storageref:StorageReference!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var contact: UITextField!
    @IBOutlet var bloodgroup: UITextField!
    @IBOutlet var name: UITextField!
var imgInfo:Any!
    
    var userDetail=[String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      

        storageref = Storage.storage().reference()
        ref = Database.database().reference()

        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addImage(_ sender: Any) {

        present(imagePicker, animated: true, completion: nil)

    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageView.image = image
             imgInfo=info["UIImagePickerControllerImageURL"]
            print("abrar___\(imgInfo)")
            print("rafay+++\(info)")
            imageSelected = true
        } else {
            print("JESS: A valid image wasn't selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addPressed(_ sender: Any) {
       
        var data = NSData()
        data = UIImageJPEGRepresentation(imageView.image!, 0.8)! as NSData
        // set upload path
        let filePath = "\(uid)/\("userPhoto")"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        self.storageref.child(filePath).putData(data as Data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                //store downloadURL
                let downloadURL = metaData!.downloadURL()!.absoluteString
                //store downloadURL at database
    self.userDetail=["Name":(self.name.text!),"Address":self.address.text!,"Contact":self.contact.text!,"BloodGroup":self.bloodgroup.text!,"Userphoto":downloadURL]
                self.ref.child("Donors").childByAutoId().setValue(self.userDetail)
//self.ref.child("photos").child(uid!).updateChildValues(["userPhoto": downloadURL])
            }
        }
        
        
        
    }
    
}
