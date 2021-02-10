//
//  DogViewModel.swift
//  BackEndWithFirebase
//
//  Created by Knoxpo MacBook Pro on 10/02/21.
//

import Foundation
import Combine
import FirebaseFirestore

class DogViewModel: ObservableObject {
    
    @Published var dog: DogModel
    @Published var modified = false
    
    private var cancable = Set<AnyCancellable>()
    
    init(dog: DogModel = DogModel(name: "", type: "", age: 0)) {
        self.dog = dog
        self.$dog
            .dropFirst()
            .sink {[weak self] dog in
        self?.modified = true
    }
    .store(in: &self.cancable)
        
        
        
        
    }
    
    
    private var db = Firestore.firestore()
    
    
    private func addDog(_ dog: DogModel){
        do {
            print("\(dog)")
            let doglist = try db.collection("dogs").addDocument(from: dog)
            print("\(doglist)")
            
            
            
        }
        catch {
            
            
            print(error)
        }
        
        
        
        
    }
    private func updateDog(_ dog: DogModel)
    {
        
        if let documentID = dog.id {
        do {
            
            try db.collection("dogs").document(documentID).setData(from: dog)
            
        }
        catch{
           print("\(error)")
            
        }
        
        
        
    }
    
    }
    
    private func updateorAddBook() {
        
        if let _ = dog.id {
            self.updateDog(self.dog)
            
            
        }
        else{
            
            self.addDog(dog)
        }
        
        
    }
    
    private func deleteBook()
    {
        
        if let docummentId = dog.id {
            
            db.collection("dogs").document(docummentId).delete { error in
                
                if let error = error {
                    
                    
                    print(error.localizedDescription)
                }
                
                
                
                
                
                
            }
            
            
        }
        
        
        
    }
    
    
    func handelDoneTapped() {
        
        self.updateorAddBook()
        
    }
    
    func handelDeleteTapped() {
        
        self.deleteBook()
        
        
        
        
    }
    
    
    
    
    
    
    
    
}
