//
//  helper.swift
//  BloodBankApp
//
//  Created by Syed  Rafay on 15/02/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import Foundation
class Donor{
    private var _name:String!
    private var _Contact:String!
    private var _address:String!
    private var _bloodgroup:String!
    private var _imageUrl:String!
    
    init(name:String,address:String,contact:String,bloodgroup:String,imageurl:String){
        
        _name=name
        _address=address
        _Contact=contact
        _bloodgroup=bloodgroup
        _imageUrl=imageurl
    }
    
    var name: String{
        return _name
    }
 
    var bloodbank: String{
        return _bloodgroup
    }
    var address: String{
        return _address
    }
    var contact: String{
        return _Contact
    }
    var imageUrl: String{
        return _imageUrl
    }
    
}

var category:String!

var userName:String!
var uid:String!

var KEY_UID="uid"
