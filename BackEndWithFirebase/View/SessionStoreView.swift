//
//  SessionStoreView.swift
//  BackEndWithFirebase
//
//  Created by Knoxpo MacBook Pro on 15/02/21.
//

import Foundation
import Combine
import Firebase

class SessionStoreView: ObservableObject {
    @Published var isLoggedIn: Bool?
 var didchange = PassthroughSubject<SessionStoreView,Never>()
    
    var session: User? { didSet  { self.didchange.send(self) }}
    var handel: AuthStateDidChangeListenerHandle?
    
    
    func listen() {
        
        handel = Auth.auth().addStateDidChangeListener { [self] (auth,user) in
            if let user = user {
                
                print("Go to user: \(user)")
                
                self.session = User (
                
                    uid: user.uid,
                    displayName: user.displayName,
                    email: user.email
                
                )
                self.isLoggedIn = true
                
            } else {
              
               // DogsListView()
                self.session = nil
                self.isLoggedIn = false
                
            }
          
        }
    
    }
    
    
    
    func signUp (
        
        email: String,
        passord: String,
        handler: @escaping AuthDataResultCallback) {
        
        Auth.auth().createUser(withEmail: email, password: passord, completion: handler)
        
        
    }
    
    func signIn (
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
        //DogsListView()
        
    }
    
    func signOut () -> Bool {
        
        do {
            
            try Auth.auth().signOut()
            self.session = nil
            
            return true
        }
        catch {
            
            return false
        }
        
        
    }
    
    
    func unwind()
    {
        if let handel = handel {
            
            Auth.auth().removeStateDidChangeListener(handel)
            
        }
        
        
        
    }
    
    
    
    
    
    
}
