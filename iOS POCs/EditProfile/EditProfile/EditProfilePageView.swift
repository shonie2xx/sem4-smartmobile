//
//  ContentView.swift
//  EditProfile
//
//  Created by Daniel Vaswani on 25/05/2021.
//

import SwiftUI

struct EditProfilePageView: View {
    @EnvironmentObject viewModel = ProfileViewModel()
    var body: some View {
        VStack{
            ImagePickerView()
            EditFormView()
            
        }.navigationTitle("My Details")
    }
}

struct ImagePickerView : View {
    
    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var sourceType:UIImagePickerController.SourceType = .camera
    @State var image:UIImage?

    
    var body : some View {
        Button(action: {
            self.showActionSheet = true
        }) {
            if image != nil {

                             Image(uiImage: image!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                    .frame(width:100, height: 100)
                                .clipShape(Circle())
                                .padding()

                         } else {

                             Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                    .frame(width:100, height: 100)
                                .foregroundColor(Color.black)
                                .padding()
                         }
          
                
        }.actionSheet(isPresented: $showActionSheet){
            ActionSheet(title: Text("Add a picture to your profile"), message: nil, buttons: [
                //Button1
                .default(Text("Camera"), action: {
                    
                    self.showImagePicker = true
                    
                    self.sourceType = .camera
                    
                }),
                
                //Button2
                
                .default(Text("Photo Library"), action: {
                    
                    self.showImagePicker = true
                    
                    self.sourceType = .photoLibrary
                    
                }),
                
                
                
                //Button3
                
                .cancel()
                
                
                
            ])
            
        }.sheet(isPresented: $showImagePicker){
            
            ImagePickerViewModel(image: self.$image, showImagePicker: self.$showImagePicker, sourceType: self.sourceType)
            
            
            
        }
        
        
    }
}

struct EditFormView : View {
    @State private var fullName = ""
    @State private var title = ""
    @State private var about = "Tell us about yourself"
    @State private var buttonTapped = false
    
    var body : some View {
        VStack{
            TextField("Full name", text :  $fullName).padding().background(Color.white).cornerRadius(10).padding().shadow(radius: 2)
            TextField("Title", text :  $title).padding().background(Color.white).cornerRadius(10).padding().shadow(radius: 2)
            
            
            TextEditor(text: $about)
                .foregroundColor(.secondary)
                .frame(height:100)
                .padding().background(Color.white).cornerRadius(10).padding().shadow(radius: 2)
                
                .disabled(buttonTapped)
            
            Spacer()
            Button(action: {
                //viewModel.save(name : fullName, title: title, about: about)
            }, label: {
                Text("Done")
            })
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
