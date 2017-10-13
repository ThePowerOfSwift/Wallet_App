//
//  Database_Modal.swift
//  wallet
//
//  Created by Ammy Pandey on 22/03/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit

class Database_Modal: NSObject {

    // Mark: Take the variables of all Coloum of database which is created by u
    //Mark: To hold data
    // User_Managment field
    var userId: Int = Int()
    var fullname: String = String()
    var username: String = String()
    var password: String = String()
    var email: String = String()
    var confirmPasswd: String = String()
    
    //Passbook Field
    var trans_id: Int = Int()
    var id: Int = Int()
    var date: String = String()
    var amount: Double = Double()
    var category: String = String()
    var detail: String = String()
    var status: String = String()
}
