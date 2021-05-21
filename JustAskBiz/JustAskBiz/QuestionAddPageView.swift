//
//  QuestionAddView.swift
//  JustAskIt
//
//  Created by Aleksandar Lekov on 20/05/2021.
//

import SwiftUI

struct QuestionAddPageView: View {
    @State private var textBody = ""
    @State private var tags = ""
    @State private var userId = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    //@StateObject var viewModel = QuestionViewModel()
    
    var body: some View {
        
        
        NavigationView{
            VStack(spacing:30){
                ZStack{
                    RoundedRectangle(cornerRadius: 10 , style:.continuous)
                        .fill(Color.white)
                        .shadow(radius: 4)
                    VStack(alignment: .leading){
                        Text("Body")
                        
                        //TextField("Type here...", text: $viewModel.question.bodyText)
                        
                        Spacer()
                        
                    }.padding(10)
                    
                }.frame(width: 392, height: 173, alignment: .center)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 10 , style:.continuous)
                        .fill(Color.white)
                        .shadow(radius: 4)
                    VStack(alignment: .leading){
                        Text("Tags")
                        
                        //TextField("Type here...", text: $viewModel.question.tags)
                        
                        Spacer()
                        
                    }.padding(10)
                    
                }.frame(width: 392, height: 100, alignment: .center)

                Spacer()
            }
            .padding(.top, 50.0)
            .navigationBarTitle("Post questions", displayMode: .inline)
            .navigationBarItems(
                leading:Button(action: {handleCancleTapped()}, label: {
                    Text("Cancel")
                }),
                trailing: Button(action: {handleDoneTapped()}, label: {
                    Text("Done")
                })
            )
        }
    }
    
    func handleDoneTapped() {
        dismiss()
        //viewModel.save()
    }
    func handleCancleTapped(){
       dismiss()
    }
    
    func dismiss(){
        presentationMode.wrappedValue.dismiss()
    }
    
    
    struct QuestionAddPageView_Previews: PreviewProvider {
        static var previews: some View {
            QuestionAddPageView()
        }
    }
    
    
}
