//
//  ContentView.swift
//  BackEndWithFirebase
//
//  Created by Knoxpo MacBook Pro on 10/02/21.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI
struct ContentView: View {
    @EnvironmentObject var session: SessionStoreView
    var bgImagw: UIImageView?
    
    @State private var showImage = false
    @State var url = ""
    func getUser()
    {
        session.listen()
        
    }
    
    
    struct Loader: UIViewRepresentable {
        
        func makeUIView(context: Context) -> UIActivityIndicatorView {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.startAnimating()
            return indicator
            
        }
        
        func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
            
        }
        
        
        
    }
    
    func downloadImage() {
        
        let storage = Storage.storage().reference()
        
        
       storage.child("images/1.png").downloadURL { (url,err) in
            if err != nil {
                
                
               return
            }
            
            self.url = "\(url!)"
            
            
        }
        
        
//        let downloadTask = storage.getData(maxSize: 5 * 1024 * 1024) { data, snapshot in
//
//
//            let image = UIImage(data: data!)
//            bgImagw?.image = image
//
           // self.bgImagw = UIImageView(image: image)
           // self.bgImagw!.frame = CGRect(x: 70, y: 20, width: 200, height: 200)
            
            
            
        }
        
        
        
        
        
        
        
    
    
    func uploadImage() {
        
        var storageRef = Storage.storage().reference()
        
        if let image = UIImage(named: "1.png") {
            
            let data = image.pngData()
            let metadata = StorageMetadata()
            
            metadata.contentType = "images/png"
            storageRef = storageRef.child("images/1.png")
            
            let uploadTask = storageRef.putData(data!, metadata: metadata)
            
            storageRef.downloadURL(completion:
                                    {
                                     (url,error) in
                                        let uploadedImageUrl = url?.absoluteString
                                        
                                    })
            
            uploadTask.observe(.progress) { snapshot in
                
                let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)/Double(snapshot.progress!.totalUnitCount)
                
                print("total percentage \(percentComplete)")
                uploadTask.observe(.success) { snapshot in
                    print("image upload successfully")
                    
                }
                uploadTask.observe(.failure) { snapshot in
                  
                    
                    if let error = snapshot.error as NSError? {
                        
                        
                        switch (StorageErrorCode(rawValue: error.code)) {
                        case .unauthorized:
                            break
                        case .invalidArgument:
                            break
                        case .unknown:
                            break
                        case .cancelled:
                            break
                        default:
                            break
                        }
                        
                        
                        
                        
                    }
                    
                    
                    
                }
                
                
            }
            
            
        }
        
       
        
        
        
        
    }
    
    
    
    var body: some View {
        
       
        NavigationView {
            VStack {
        Group {
            
            if (session.session != nil)
            {
                Text("hello user")
                DogsListView()
                
                if url != "" {
                    
                    AnimatedImage(url: URL(string: url)!).frame( height: 250).padding().cornerRadius(25)
                    
                    
                }
                else
                {
                    
                    Loader()
                   // downloadImage()
                }
                
                
            }
            
            else{
                
               // Text("our Auth screen is here")
                SignInView()
            }
            
            
        }
    .onAppear(perform: getUser)
//        .onAppear{
//
//            let storage = Storage.storage().reference()
//
//
//            storage.child("images/1.png").downloadURL { (url,err) in
//                if err != nil {
//
//
//                   return
//                }
//
//                self.url = "\(url!)"
//
//
//            }
//
//
//
//        }
        
          

                
        .navigationBarItems(
            leading: Button(action: {
                session.signOut()
            }, label: { Text("Logout") }),

            trailing: Button(action: {
              //  self.uploadImage()
                self.downloadImage()
            }, label: { Text("UploadImage") })
        )
                
                
                
        
                
                
                
            }
            
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SessionStoreView())
    }
}
