//
//  User.swift
//  BackEndWithFirebase
//
//  Created by Knoxpo MacBook Pro on 15/02/21.
//

import Foundation

class User {
    var uid: String
    var email: String?
    var displayName: String?
    
    init(uid:String, displayName: String?, email: String?) {
        
        
        self.uid = uid
        self.email = email
        self.displayName = displayName
        
    }
    
    
    
    
}
