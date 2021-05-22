////
////  SignUp.swift
////  JustAskBizz
////
////  Created by Aleksandar Lekov on 21/05/2021.
////
//
//import SwiftUI
//
//struct RegisterView: View {
//    @State var email = ""
//    @State var password = "" 
//    
//    @ObservedObject private var viewModel = AuthViewModel()
//    
//    var body: some View {
//        NavigationView{
//            VStack{
//                Text("Register page").bold().padding()
//               
//                TextField("Email:",text: $email)
//                
//                SecureField("Password:",text: $password)
//                
//                Button(action: {
//                    guard !email.isEmpty, !password.isEmpty else{
//                        return
//                    }
//                    
//                    viewModel.signUp(email: email, password: password)
//                    
//                }, label: {
//                    Text("Register")
//                })
//                Spacer()
//            }
//        }
//    }
//}
//
//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView()
//    }
//}
