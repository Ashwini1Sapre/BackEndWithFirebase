//
//  DogsViewModel.swift
//  BackEndWithFirebase
//
//  Created by Knoxpo MacBook Pro on 10/02/21.
//

import Foundation
import Combine
import FirebaseFirestore

class DogsViewModel: ObservableObject {
    @Published var dogs = [DogModel]()
    private var db = Firestore.firestore()
    private var listnerRegister: ListenerRegistration?
    
    
   deinit
    {
        unSubscribe()
        
        
    }
    
    func unSubscribe()
    {
        if listnerRegister != nil
        {
            listnerRegister?.remove()
            listnerRegister = nil
        
         }
    
    }
    
    func subscribe()
    {
        
        if listnerRegister == nil{
            
            listnerRegister = db.collection("dogs").addSnapshotListener { (querysnapshot, error) in
                
                
                guard let document = querysnapshot?.documents else {
                    print("no data")
                    return}
                
                self.dogs = document.compactMap { querysnapshotmap in
                    return try? querysnapshotmap.data(as: DogModel.self)
               
                }
           
                
            }
          
        }
      
     }
    
    func remove(atOffsets indexset: IndexSet)
    {
        let books = indexset.lazy.map{ self.dogs[$0] }
        dogs.forEach { dog in
            
            if let docId = dog.id {
                
                db.collection("dogs").document(docId).delete { error in
                    
                    if let error = error
                    {
                        
                        print("\(error)")
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            
            
            
            
            
        }
        
        
        
    }
    
    
   
    
    
    
}
