//
//  ViewController.swift
//  BloodBankApp
//
//  Created by Syed  Rafay on 14/02/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import SwiftKeychainWrapper

class ViewController: UIViewController {

    @IBOutlet var password: UITextField!
    @IBOutlet var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.defaultKeychainWrapper.string(forKey: KEY_UID){
            print("JESS: ID found in keychain")
            performSegue(withIdentifier: "gotoDonors", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func loginPressed(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                let keychainResult = KeychainWrapper.defaultKeychainWrapper.set((user?.uid)!, forKey: KEY_UID)
                self.performSegue(withIdentifier: "gotoDonors", sender: nil)
            }
        }
        
    }
    
    
    @IBAction func gotoRegitration(_ sender: Any) {
        performSegue(withIdentifier: "gotoRegister", sender: nil)
    }
    
}

