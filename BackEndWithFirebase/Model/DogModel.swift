//
//  DogModel.swift
//  BackEndWithFirebase
//
//  Created by Knoxpo MacBook Pro on 10/02/21.
//

import Foundation
import FirebaseFirestoreSwift

struct DogModel: Identifiable, Codable{
   @DocumentID var id: String?
    var name: String
    var type: String
    var age: Int
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case age = "ages"
        
        
    }
    
    
    
}

