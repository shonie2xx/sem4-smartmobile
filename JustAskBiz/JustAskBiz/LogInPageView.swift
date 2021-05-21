//
//  ContentView.swift
//  JustAskBiz
//
//  Created by Daniel Vaswani on 21/05/2021.
//

import SwiftUI

// Presentation mode hide
struct LogInPageView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var oldUser = false
    var body: some View {
        
        
        NavigationView {
            VStack (spacing: 30){
                VStack{
                    if oldUser {
                        TextField("Name", text : $email)
                            .padding(.horizontal, 5.0)
                            .background(Color.white)
                            .cornerRadius(3.0)
                            .shadow(radius: 0.5)
                    }
                    TextField("Email Address", text : $email)
                        .padding(.horizontal, 5.0)
                        .background(Color.white)
                        .cornerRadius(3.0)
                        .shadow(radius: 0.5)
                    TextField("Password", text : $password)
                        .padding(.horizontal, 5.0)
                        .background(Color.white)
                        .cornerRadius(3.0)
                        .shadow(radius: 0.5)
                    
                }.padding()
                
                
                Button(action: {
                        if(oldUser){
                            handleSignIn()
                        }else {
                            handleSignUp()
                        }
                        handleSignIn()}, label: {
                            Text(oldUser ? "Sign Up" : "Sign In")
                        })
                Button(action: {oldUser.toggle()}, label: {
                    Text(oldUser ? "Already have an account?" : "Dont have an account?")
                })
                Spacer()
            }.navigationTitle(oldUser ? "Sign Up" : "Sign In")
        }
        
        
        
    }
}

func handleSignIn() {
    // loginViewModel.signIN (email, password)
    
    //Presentation mode change
}

func handleSignUp() {
    //loginViewModel.signIN (name, email, password)
    // once signup is done, automatically sign in ----> ViewModel
    
    //Presentation mode change
}


struct LogInPageView_Previews: PreviewProvider {
    static var previews: some View {
        LogInPageView()
    }
}
