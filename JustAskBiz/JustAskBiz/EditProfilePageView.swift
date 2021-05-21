//
//  EditProfilePageView.swift
//  JustAskBiz
//
//  Created by Daniel Vaswani on 21/05/2021.
//

import SwiftUI

struct EditProfilePageView: View {
    @State private var name = ""
    @State private var experience = ""
    @State private var info = ""
    @State private var email = ""
    var body: some View {
        NavigationView{
            VStack {
                
                //Image(systemName: "pencil")
                
                Form{
                    Section(header: Text("Personal Details")){
                        TextField("Full name", text : $name)
                        TextField("Business title", text : $experience)
                        
                        
                        TextField("Contact email", text : $email)
                        
                    }
                    
                    Section(header : Text("About you")){
                        TextField("", text: $info)
                            .lineLimit(4)
                                        .multilineTextAlignment(.leading)
                                        .frame(minWidth: 100, maxWidth: 200, minHeight: 100, maxHeight: .infinity, alignment: .topLeading)
                        
                    }
                    
                }.navigationTitle("My details").navigationBarTitleDisplayMode(.inline)
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
