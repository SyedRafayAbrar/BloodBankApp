//
//  DonorTableViewCell.swift
//  BloodBankApp
//
//  Created by Syed  Rafay on 14/02/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit

class DonorTableViewCell: UITableViewCell {
    let donObj = DonorsViewController()

    @IBOutlet var blur: UIVisualEffectView!
    @IBOutlet var uImage: UIImageView!
    @IBOutlet var bloodGroup: UILabel!
    @IBOutlet var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    
   
}
extension UITableViewCell {
    func setTransparent() {
        let bgView: UIView = UIView()
        bgView.backgroundColor = .clear
        
        self.backgroundView = bgView
        self.backgroundColor = .clear
    }
}
