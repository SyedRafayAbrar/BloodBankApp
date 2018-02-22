//
//  DonorDetailViewController.swift
//  BloodBankApp
//
//  Created by Syed  Rafay on 15/02/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit

class DonorDetailViewController: UIViewController {
    @IBOutlet var dImage: UIImageView!
    
    @IBOutlet var contact: UILabel!
    @IBOutlet var Address: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var bloodgrp: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        bloodgrp.text = list[newindex]["BloodGroup"]!
        Address.text = list[newindex]["Address"]!
        name.text = list[newindex]["Name"]
        contact.text = list[newindex]["Contact"]!
        let url = list[newindex]["image"]!
        
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
                            self.self.dImage.image = image
                          
                            
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

}
