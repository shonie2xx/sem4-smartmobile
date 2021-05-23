//
//  EditProfilePageView.swift
//  JustAskBiz
//
//  Created by Daniel Vaswani on 21/05/2021.
//

import SwiftUI
import FirebaseAuth

struct EditProfilePageView: View {
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    @State private var name = ""
    @State private var experience = ""
    @State private var info = ""
    @State private var email = ""
    @State private var userId = Auth.auth().currentUser!.uid
    
    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var sourceType:UIImagePickerController.SourceType = .camera
    @State var image:UIImage?
    
    var body: some View {
        NavigationView{
            VStack {
                if image != nil {
                    Image(uiImage: image!)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(15)
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                            .frame(width:60, height:60)
                        .padding(15)
                }
                Button(action: {
                    self.showActionSheet = true
                }) {
                    Text("Edit Picture")
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
                
                Form{
                    Section(header: Text("Personal Details")){
                        TextField("Full name", text : $profileViewModel.profile.name)
                        TextField("Business title", text : $profileViewModel.profile.title)
                        TextField("Contact email", text : $profileViewModel.profile.email)
                    }
                    Section(header : Text("About you")){
                        TextField("", text: $profileViewModel.profile.about)
                            .lineLimit(4)
                            .multilineTextAlignment(.leading)
                            .frame(minWidth: 100, maxWidth: 200, minHeight: 100, maxHeight: .infinity, alignment: .topLeading)
                    }
                }.navigationTitle("My details").navigationBarTitleDisplayMode(.inline)
                .onAppear() {
                    self.profileViewModel.fetchData(userId: userId)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            print("Help tapped!")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Done")
                        })
                    }
                }
            }
        }
    }
}

struct EditProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfilePageView()
    }
}
