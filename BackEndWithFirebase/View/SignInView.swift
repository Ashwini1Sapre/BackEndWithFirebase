//
//  SignInView.swift
//  BackEndWithFirebase
//
//  Created by Knoxpo MacBook Pro on 15/02/21.
//

import SwiftUI

struct SignInView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var loading  = false
    @State var error = false
    @EnvironmentObject var session: SessionStoreView
    
    
    func nextView()
    {
        
       // DogsListView()
    }
    
    
    
    func signIn() {
       loading = true
        error = false
        session.signIn(email: email, password: password) { (result,error) in
            
            self.loading = false
            
            if error != nil {
                
                self.error = true
             
                
            } else {
                self.email = ""
                self.password = ""
               // DogsListView()
               
            }
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    
    var body: some View {
        VStack {
            
            
            
            TextField("Enter Name", text: $email)
            SecureField("Enter password", text: $password)
            if error {
                
                Text("error occur")
               // print("\(error)")
            }
            
            
            Button(action: {
                      print("SwiftUI: Button tapped")
                      // Call func in SomeView()
                
            //    DogsListView()
                signIn()
              nextView()
           //     DogsListView()
                    //  self.someView.callFoo()
                    })
           {
                
                Text("SignIN")
               // DogsListView()
                
            }
            
            
            
            
            
        }
        .onAppear() {
         
         //  DogsListView()
         //   print("dolist appear now show sibscrivnbe list")
            
        }
        
        
        
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
