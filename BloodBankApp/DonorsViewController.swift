//
//  DonorsViewController.swift
//  BloodBankApp
//
//  Created by Syed  Rafay on 14/02/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftKeychainWrapper
import FirebaseDatabase

class DonorsViewController: UIViewController,UITableViewDelegate {
  
    @IBOutlet var tableView: UITableView!
    @IBOutlet var blurView: UIVisualEffectView!
    let touch = UITouch()
    @IBOutlet var catViewLeading: NSLayoutConstraint!
    @IBOutlet var categoryView: UIView!
   var ref: DatabaseReference!
    var listDict = ["Name":"","Address":"","Contact":"","BloodGroup":"","image":""]
  
    var list = [[String:String]]()
    override func viewDidLoad() {

 
        tableView.reloadData()
        super.viewDidLoad()
blurView.layer.cornerRadius = 4
        tableView.backgroundColor = .clear
        
        tableView.separatorStyle = .singleLine
        // Do any additional setup after loading the view.
  catViewLeading.constant = -240;
       
        
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        
        if let user = user {
            uid = user.uid
            userName = user.email
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
    fetchData()
                tableView.reloadData()
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
    @IBAction func filterPressed(_ sender: Any) {
        if catViewLeading.constant == -240{
            catViewLeading.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded() })
        }else{
            catViewLeading.constant = -240
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded() })
        }
        
        

    }
    
   
    @IBAction func AddDonorPressed(_ sender: Any) {
        performSegue(withIdentifier: "addDonor", sender: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
   
            catViewLeading.constant = -240
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded() })
        
    }
    
    
    @IBAction func bloodGroup(_ sender: Any) {
       
        guard let button = sender as? UIButton else {
            return
        }
        
        switch button.titleLabel?.text! {
        case "A+"?:
            category="A+"
        case "A-"?:
            category="A-"
        case "B+"?:
            category="B+"
        case "B-"?:
            category="B-"
        case "O+"?:
            category="O+"
        case "O-"?:
            category="O-"
        case "AB+"?:
            category="AB+"
        case "AB-"?:
            category="AB-"
            
        default:
            print("Nothing Happen")
        }
        print(category)
    }
    @IBAction func logOutPressed(_ sender: Any) {
         let keychainResult = KeychainWrapper.defaultKeychainWrapper.remove(key: KEY_UID)
        try! Auth.auth().signOut()
        dismiss(animated: true, completion: nil)

        
    }
    
    func fetchData(){
       
        ref.child("Donors").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
            let value = snapshot.value as? NSDictionary
           print("Rafay-- \(value!)")
            if let fetched = value![uid!] as? [String:Any]{
                if let name = fetched["Name"] as? String{
                    self.listDict["name"]=name
                    
                }
                if let address = fetched["Address"] as? String{
                   self.listDict["Address"]=address

                }
                if let contact = fetched["Contact"] as? String{
                   self.listDict["Contact"]=contact
                }
                if let bloodgrp = fetched["BloodGroup"] as? String{
                   self.listDict["BloodGroup"]=bloodgrp
                }
                if let photo = fetched["Userphoto"] as? String{
                   self.listDict["image"]=photo
                    
                }
            }
            
print(self.listDict)
            print("list\(self.list)")
            self.list.append(self.listDict)
            print(self.list)
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}

extension DonorsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell = Bundle.main.loadNibNamed("DonorTableViewCell", owner: self, options: nil)?.first as! DonorTableViewCell
        tempCell.name.text! = list[indexPath.row]["name"]!

        tempCell.bloodGroup.text! = list[indexPath.row]["BloodGroup"]!
        return tempCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoDetails", sender: nil)
    }
    
}
