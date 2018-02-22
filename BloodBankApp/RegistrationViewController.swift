//
//  RegistrationViewController.swift
//  BloodBankApp
//
//  Created by Syed  Rafay on 14/02/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class RegistrationViewController: UIViewController {

    @IBOutlet var password2: UITextField!
    @IBOutlet var password1: UITextField!
    @IBOutlet var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

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

    @IBAction func signupPressed(_ sender: Any) {
        
    
        Auth.auth().createUser(withEmail: email.text!, password: password1.text!) { (user, error) in
            if error != nil{
                print("Error occured\(error!)")
            }else{
                
                 self.dismiss(animated: true, completion: nil)

            }
        }
       
            }
       
       
        

}
