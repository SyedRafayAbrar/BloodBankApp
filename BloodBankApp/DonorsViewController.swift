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
    var ref2:DatabaseReference!
  var gameTimer: Timer!
  

   
    override func viewDidLoad() {

        tableView.backgroundView?.backgroundColor = .clear ;
        
        super.viewDidLoad()
blurView.layer.cornerRadius = 4
        tableView.backgroundColor = .clear
        
        tableView.separatorStyle = .singleLine
        // Do any additional setup after loading the view.
  catViewLeading.constant = -240;
       
        
        let user = Auth.auth().currentUser
        
        if let user = user {
            uid = user.uid
            userName = user.email
        }
        
      
        if list.count == 0 {
           
            getID()
            fetchData()

  gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)

        }

    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        if categorySelected == "" {
        if list.count != 0 {
            childKey.removeAll()
            list.removeAll()
            getID()
            fetchData()

        
          gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)

        tableView.reloadData()
        }
        
      }else{
        childKey.removeAll()
        list.removeAll()
        getselectedID()
        fetchData()
        gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
        
        tableView.reloadData()

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func runTimedCode(){
        tableView.reloadData()
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
            categorySelected = "A+"
        // Change to English
        case "A-"?:
            categorySelected = "A-"
            
        case "B+"?:
            categorySelected = "B+"
            
        case "B-"?:
            categorySelected = "B-"
            
        case "O+"?:
            categorySelected = "O+"
            
        case "O-"?:
            categorySelected = "O-"
            
        case "AB+"?:
            categorySelected = "AB+"
       
        case "AB-"?:
            categorySelected = "AB-"
            
        default:
            print("Unknown language")
            return
        }

        
        if list.count != 0 {
            childKey.removeAll()
            list.removeAll()
            getselectedID()
            fetchData()

            gameTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
            

        }
        catViewLeading.constant = -240
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded() })
        
    }
    @IBAction func logOutPressed(_ sender: Any) {
        KeychainWrapper.defaultKeychainWrapper.removeObject(forKey: KEY_UID)
        try! Auth.auth().signOut()
        dismiss(animated: true, completion: nil)

        
    }
    
    
    @IBAction func fetchPressed(_ sender: Any) {
        
    }
    
}

extension DonorsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell = Bundle.main.loadNibNamed("DonorTableViewCell", owner: self, options: nil)?.first as! DonorTableViewCell
        tempCell.name.text! = list[indexPath.row]["Name"]!
        tempCell.bloodGroup.text! = list[indexPath.row]["BloodGroup"]!
       
        // -------------------  img -------------------
        let url = list[indexPath.row]["image"]!

        let URL_IMAGE = URL(string: url)
        let session = URLSession(configuration: .default)

        //creating a dataTask
        let getImageFromUrl = session.dataTask(with: URL_IMAGE!) { (data, response, error) in

            //if there is any error
            if let e = error {
                //displaying the message
                print("Error Occurred: \(e)")

            } else {
                  DispatchQueue.main.async {

                //in case of now error, checking wheather the response is nil or not
                if (response as? HTTPURLResponse) != nil {

                    //checking if the response contains an image
                    if let imageData = data {

                        //getting the image
                        let image = UIImage(data: imageData)

                        //displaying the image
                        tempCell.uImage.image = image
                        

                    } else {
                        print("Image file is currupted")
                    }
                } else {
                    print("No response from server")
                }
                }

            }

        }
        getImageFromUrl.resume()
        //starting the download task




        // -------------------  img -------------------
       
        
//         let bongtuyet:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 148, height: 108))
        return tempCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       newindex=indexPath.row
        performSegue(withIdentifier: "gotoDetails", sender: nil)
    }
    
    
    
}
