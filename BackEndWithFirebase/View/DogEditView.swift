//
//  DogEditView.swift
//  BackEndWithFirebase
//
//  Created by Knoxpo MacBook Pro on 10/02/21.
//

import SwiftUI
enum mode {
  case new
    case edit
    
}

enum action{
    
    case delete
    case done
    case cancel
    
}
struct DogEditView: View {
    
    
    
    //presentationMode
    @Environment(\.presentationMode) private var presentionMode
    @State var PresentationSheet = false
    
    @ObservedObject var viewModel1 = DogViewModel()
    var Mode: mode = .new
    var completionHandler: ((Result<action, Error>) -> Void)?
    
    var cancelButton: some View {
        
        Button(action: { self.handelCancelTapped() })
            {
            Text("cancel")
            
        }
    }
    
    
    var saveButton: some View {
        
Button(action: { self.handelDoneButton() }) {
            
            Text(Mode == .new ? "Done" : "Save")
            
        }
        .disabled(!viewModel1.modified)
    }
    
    
    
    
    
    var body: some View {
        NavigationView {
        Form {
            
            Section(header: Text("Dogs")){
                
                TextField("Name",text: $viewModel1.dog.name)
                
                TextField("Age",value :$viewModel1.dog.age, formatter: NumberFormatter())
                
            }
            
            Section(header: Text("Type")) {
                
                TextField("Type",text: $viewModel1.dog.type)
                
            }
            
            if Mode == .edit {
                Section {
                    Button("Delete Button"){
                        
                        self.PresentationSheet.toggle()
                        
                    }
                    .foregroundColor(.blue)
                    
                }
                
                
            }
            
            
            
            
            
        }
        .navigationTitle(Mode == .new ? "newmodel" : viewModel1.dog.name
        )
        .navigationBarTitleDisplayMode(Mode == .new ? .inline : .large)
        
        .navigationBarItems(
           leading: cancelButton,
            trailing: saveButton
        
        )
        
        .actionSheet(isPresented: $PresentationSheet) {
            
            ActionSheet(title: Text("Are want to delete"), buttons: [
                .destructive(Text("delete dog"),action: { self.handelDeleteTapped() }),
        .cancel()
            ])
           }
            
        }
        
    }

    
    func handelDoneButton() {
        
        viewModel1.handelDoneTapped()
        self.dismiss()
        
        
    }
    
    func handelDeleteTapped(){
        
        viewModel1.handelDeleteTapped()
        self.dismiss()
        self.completionHandler?(.success(.delete))
        
    }
    
    
    
    
    func handelCancelTapped()
    {
        
        self.dismiss()
        
        
    }
    
    
    func dismiss() {
        self.presentionMode.wrappedValue.dismiss()
        
    }
    
    
}

struct DogEditView_Previews: PreviewProvider {
    static var previews: some View {
        
        let dog = DogModel(name: "horn", type: "sds", age: 4)
        let dogmodel = DogViewModel(dog: dog)
        return DogEditView(viewModel1:dogmodel, Mode: .edit)
    }
}
