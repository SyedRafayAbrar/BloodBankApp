//
//  DonorsViewController.swift
//  BloodBankApp
//
//  Created by Syed  Rafay on 14/02/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit

class DonorsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
let touch = UITouch()
    @IBOutlet var catViewLeading: NSLayoutConstraint!
    @IBOutlet var categoryView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        catViewLeading.constant = -240;
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
       
        catViewLeading.constant = 0;
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded() })
        

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell = Bundle.main.loadNibNamed("DonorTableViewCell", owner: self, options: nil)?.first as! DonorTableViewCell
        return tempCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150;
    }
    
    
    @IBAction func AddDonorPressed(_ sender: Any) {
        performSegue(withIdentifier: "addDonor", sender: nil)
    }
    
}
