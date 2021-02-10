//
//  DogDetailView.swift
//  BackEndWithFirebase
//
//  Created by Knoxpo MacBook Pro on 10/02/21.
//

import SwiftUI



struct DogDetailView: View {
    
    @Environment(\.presentationMode) var presationMode
   @State var presentationEditDogSheet = false
    
    
    var dog: DogModel
    
    private func editButton(action: @escaping () -> Void) -> some View {
        
        Button(action: { action() }) {
            
            Text("Edit")
        }
        
        
    }
    
    
    var body: some View {
        Form {
            Section(header: Text("Dogs")) {
                Text(dog.name)
                Text("\(dog.age)")
                
                
            }
            
            
            Section(header: Text("DogType")) {
                Text(dog.type)
                
            }
            
            
            
        }
        
        .navigationBarTitle(dog.name)
        .navigationBarItems(trailing: editButton {
            self.presentationEditDogSheet.toggle()
            
        })
        .onAppear() {
            
            print("\(self.dog.name)")
            
        }
        .onDisappear() {
            
            print("BookDetails")
        }
        
        .sheet(isPresented: self.$presentationEditDogSheet) {
//    DogEditView(viewModel: DogViewModel(dog: DogModel), Mode: .edit) { result in
//                if case .success(let action)  = result, action == .delete {
//
//                    self.presationMode.wrappedValue.dismiss()
//                }
//
//
//            }
            //here is edit view
            
            
            
        }
        
        
    }
}

struct DogDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let dog = DogModel(name: "tomy", type: "dollerdog", age: 5)
        return
        
        DogDetailView(dog: dog)
    }
}
