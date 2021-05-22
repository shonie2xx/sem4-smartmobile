////
////  SignIn.swift
////  JustAskBizz
////
////  Created by Aleksandar Lekov on 21/05/2021.
////
//
//import SwiftUI
//
//
//struct LoginView: View {
//    @State var email = ""
//    @State var password = ""
//    
//    @ObservedObject private var viewModel = AuthViewModel()
//
//    var body: some View {
//        if viewModel.isSignedIn {
//            Text("you are signed in")
//        }
//        else{
//                VStack{
//                    Text("Login page").bold().padding()
//                   
//                    TextField("Email:",text: $email)
//                    
//                    SecureField("Password:",text: $password)
//                    
//                    Button(action: {
//                        guard !email.isEmpty, !password.isEmpty else{
//                            return
//                        }
//                        
//                        viewModel.signIn(email: email, password: password)
//                        
//                    }, label: {
//                        Text("Login")
//                    })
//                    Spacer()
//                }
//        }
//        
//    }
//}
//
//
//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
