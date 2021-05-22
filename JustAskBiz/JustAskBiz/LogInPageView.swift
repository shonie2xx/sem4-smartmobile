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
    
    @ObservedObject var viewModel = AuthViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationView {
            VStack (spacing: 30){
                VStack{
                    if oldUser {
                        TextField("Name", text : $name)
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
                        .disableAutocorrection(true)
                    SecureField("Password", text : $password)
                        .padding(.horizontal, 5.0)
                        .background(Color.white)
                        .cornerRadius(3.0)
                        .shadow(radius: 0.5)
                        .disableAutocorrection(true)
                    
                }.padding()
                
                
                Button(action: {
                    if(oldUser){
                        viewModel.signIn(email: email, password: password)
                    }else {
                        viewModel.signUp(email: email, password: password)
                    }
                    presentationMode.wrappedValue.dismiss()
                }, label: {
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
