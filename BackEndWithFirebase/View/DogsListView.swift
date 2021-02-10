//
//  DogsListView.swift
//  BackEndWithFirebase
//
//  Created by Knoxpo MacBook Pro on 10/02/21.
//


import SwiftUI


struct DogsListView: View {
   
    
    @StateObject var dogsmodel = DogsViewModel()
    @State var presentAddDogs = false
    
    
    private var addButton: some View {
        Button (action: { self.presentAddDogs.toggle() } ){
            
            Image(systemName: "plus")
        }
        
        
        
    }
  
    
    private func DogRowList(dog: DogModel) -> some View {
    NavigationLink(
        destination: DogDetailView(dog:dog))
        {
        
        VStack(alignment: .leading) {
            Text(dog.name)
                .font(.headline)
            Text(dog.type)
            font(.subheadline)
            Text("\(dog.age)")
                .font(.subheadline)
            
            
            
        }
        
        
    }
        
    
    
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(dogsmodel.dogs) { dog in
                    
                    DogRowList(dog: dog)
                    
              
                }
                .onDelete() { indexSet  in
                    dogsmodel.remove(atOffsets: indexSet)
            
                }
              
            }
            
            .navigationBarTitle("Dogs")
            .navigationBarItems(trailing: addButton)
            
            .onAppear() {
                print("dolist appear now show sibscrivnbe list")
                dogsmodel.subscribe()
                
                
            }
            .onDisappear() {
                
                
            }
            
        
            .sheet(isPresented: self.$presentAddDogs) {
            //here is edit view
            DogEditView()
        }
            
        }
        
        
        
    }
    
    
    
    
    
}



struct DogsListView_Previews: PreviewProvider {
    static var previews: some View {
        
        DogsListView()
        
    }
}












