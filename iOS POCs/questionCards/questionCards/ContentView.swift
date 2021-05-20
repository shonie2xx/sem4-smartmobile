//
//  ContentView.swift
//  questionCards
//
//  Created by Daniel Vaswani on 20/05/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var experience = ""
    @State private var info = ""
    @State private var email = ""
    var body: some View {
        VStack(alignment: .trailing){
            QuestionsView(question : "The quick brown fox jumps over the lazy dog")
            QuestionsView(question : "The quick brown fox jumps over the lazy dog")
            QuestionsView(question: "The quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dog")
        }
        
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

struct QuestionsView : View {
    var question : String
    
    var body : some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10 , style:.continuous)
                .fill(Color.white)
                .shadow(radius: 4)
            VStack{
                HStack{
                    Text("New Question")
                    Spacer()
                    Text("13 May")
                }
                VStack{
                    HStack{
                        Image(systemName: "pencil")
                            .renderingMode(.original)
                            .resizable(capInsets: EdgeInsets(top: 7.0, leading: 6.0, bottom: 8.0, trailing: 9.0), resizingMode: .tile)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60.0, height: 60.0)
                            
                        VStack {
                            
                            Text("John Doe")
                            Text("Business owner")
                            Text("25k followers")
                        }
                        Spacer()
                        VStack{
                            Text("23 comments")
                                
                            Text("23000 Watching")
                            Text("Watch")
                                .padding(10)
                                
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.white)
                        }
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(.white)
                            .shadow(radius: 1)
                        Text(question)
                    }
                   
                        Text("View answers - 10")
                            .foregroundColor(Color.blue)
                    
                    
                        
                }
                
            }.padding(10)
        }
        .padding()
        .frame(width: 430, height: 300)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
