//
//  EditProfilePageView.swift
//  JustAskBiz
//
//  Created by Daniel Vaswani on 21/05/2021.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import Firebase

struct EditProfilePageView: View {
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    let database = Firestore.firestore()
    
    @State private var name = ""
    @State private var experience = ""
    @State private var info = ""
    @State private var email = ""
    @State private var userId = Auth.auth().currentUser!.uid
    @State private var isUpdate = false
    
    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var sourceType:UIImagePickerController.SourceType = .camera
    @State var image:UIImage?
    
    @State var upload_image:UIImage?
    @State var download_image:UIImage?
    
    
    var body: some View {
        NavigationView{
            VStack {
                //Uploading image
                if upload_image != nil {
                    Image(uiImage: upload_image!)
                        .resizable()
                        .scaledToFit()
                        .frame(width:120, height:120)
                } else {
                    Image(systemName: "timelapse")
                        .resizable()
                        .scaledToFit()
                        .frame(width:300, height:300)
                }
                Spacer()
                if download_image != nil {
                    Image(uiImage: download_image!)
                        .resizable()
                        .scaledToFit()
                        .frame(width:120, height:120)
                } else {
                    Image(systemName: "timelapse")
                        .resizable()
                        .scaledToFit()
                        .frame(width:120, height:120)
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
                //Button for upload
                Button(action: {
                    if let thisImage = self.upload_image {
                        Storage.storage()
                        uploadImage(image: thisImage)
                    } else {
                        print("")
                    }
                    
                }){
                    Text("Upload Image")
                }
                
                Button(action: {
                    Storage.storage().reference().child("temp").getData(maxSize: 2 * 1024 * 1024){
                        (imageData, err) in
                        if let err = err {
                            print("an error has occurred - \(err.localizedDescription)")
                        } else {
                            if let imageData = imageData {
                                self.download_image = UIImage(data: imageData)
                            } else {
                                print("couldn't unwrap image data image")
                            }
                            
                        }
                    }
                }){
                    Text("Download Image")
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
                        NavigationLink(
                            destination: ProfilePageView(),
                            label: {
                                Text("Cancel")
                            })
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        Button(action: {
                            self.updateProfile(name: name, title: title, email: email, about: about, profileImageUrl: profileImageUrl)
                        }) {
                            Text("Save")
                        }
                        Spacer()
                        
                        //                        NavigationLink(
                        //                            destination: ProfilePageView(),
                        //                            label: {
                        //                                Text("Save")
                        //                            })
                    }
                }
            }
        }
    }
    
//    func updateProfile(name: String, title: String, email: String, about: String, profileImageUrl: String) {
//        self.isUpdate ? database.updateData(
//            name : name,
//            title : title,
//            email : email,
//            about : about,
//            profileImageUrl : profileImageUrl)
//    }
//
    
    func uploadImage(image:UIImage){
        if let imageData = image.jpegData(compressionQuality: 1){
            let storage = Storage.storage()
            storage.reference().child("temp").putData(imageData, metadata: nil){
                (_, err) in
                if let err = err {
                    print("an error has occurred - \(err.localizedDescription)")
                } else {
                    print("image uploaded successfully")
                }
            }
        } else {
            print("coldn't unwrap/case image to data")
        }
    }
}

struct EditProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfilePageView()
    }
}
