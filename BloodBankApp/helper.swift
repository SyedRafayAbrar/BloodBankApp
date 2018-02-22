//
//  helper.swift
//  BloodBankApp
//
//  Created by Syed  Rafay on 15/02/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth


var ref: DatabaseReference!
var listDict = ["Name":"","Address":"","Contact":"","BloodGroup":"","image":""]

var categorySelected:String = ""
var newindex:Int!
var userName:String!
var list = [[String:String]]()

var uid:String!
var childKey=[String]()
var KEY_UID="uid"
func getID(){
    ref = Database.database().reference()
    ref.child("Donors").observeSingleEvent(of: .value) { (snapshot) in
        if snapshot.exists()==true{
            for child in snapshot.children {
                print("1")
                let snap = child as! DataSnapshot
                let key = snap.key
                childKey.append(key)
                
                
            }
            print("child-- \(childKey)")
        }
    }
  
}

func getselectedID(){
    ref = Database.database().reference()
    ref.child("Donors").queryOrdered(byChild: "BloodGroup").queryEqual(toValue: categorySelected).observeSingleEvent(of: .value) { (snapshot) in
        if snapshot.exists()==true{
            for child in snapshot.children {
                print("1")
                let snap = child as! DataSnapshot
                let key = snap.key
                childKey.append(key)
                
                
            }
            print("child-- \(childKey)")
        }
    }
    
}

func fetchData(){
   if categorySelected == "" {
    print("eeeee\(childKey)")
    ref = Database.database().reference()
    ref.child("Donors").observeSingleEvent(of: .value, with: { (snapshot) in
        // Get user value
        if snapshot.exists()==true{
            for i in childKey{
                print("rrrr\(i)")
                if let value = snapshot.value as? NSDictionary{
                    print("Rafay-- \(value)")
                    if let fetched = value[i] as? [String:Any]{
                        if let name = fetched["Name"] as? String{
                            listDict["Name"]=name
                            
                        }
                        if let address = fetched["Address"] as? String{
                            listDict["Address"]=address
                            
                        }
                        if let contact = fetched["Contact"] as? String{
                            listDict["Contact"]=contact
                        }
                        if let bloodgrp = fetched["BloodGroup"] as? String{
                            listDict["BloodGroup"]=bloodgrp
                        }
                        if let photo = fetched["Userphoto"] as? String{
                            listDict["image"]=photo
                            
                        }
                        list.append(listDict)
                    }
                }
                
                
                
                
            }
                print(listDict)
            
            
                print("ppppp\(list)")
        } else{
            let alert = UIAlertController(title: "Not Found", message: "Not found Data", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(cancel)
            alert.show(alert, sender: nil)
        }
        // ...
    }) { (error) in
        print(error.localizedDescription)
    }
   } else {
    
    
    ref = Database.database().reference()
    ref.child("Donors").queryOrdered(byChild: "BloodGroup").queryEqual(toValue: categorySelected).observeSingleEvent(of: .value, with: { (snapshot) in
    
                if snapshot.exists() == true {
                    
                    for i in childKey{
                        print("rrrr\(i)")
                        if let value = snapshot.value as? NSDictionary{
                            print("Rafay-- \(value)")
                            if let fetched = value[i] as? [String:Any]{
                                if let name = fetched["Name"] as? String{
                                    listDict["Name"]=name

                                }
                                if let address = fetched["Address"] as? String{
                                    listDict["Address"]=address

                                }
                                if let contact = fetched["Contact"] as? String{
                                    listDict["Contact"]=contact
                                }
                                if let bloodgrp = fetched["BloodGroup"] as? String{
                                    listDict["BloodGroup"]=bloodgrp
                                }
                                if let photo = fetched["Userphoto"] as? String{
                                    listDict["image"]=photo

                                }
                                list.append(listDict)
                            }
                        }




                    }
                    print(listDict)


                    print("ppppp\(list)")
                }else{
                    let alert = UIAlertController(title: "Not Found", message: "Not found Data", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(cancel)
                    alert.show(alert, sender: nil)
        }
    
            })
    //        db.orderByChild("BloodGroup").equalTo(categorySelected).on("child_added", function(snapshot) {
    //            console.log(snapshot.key);
    //        });
    }

}
