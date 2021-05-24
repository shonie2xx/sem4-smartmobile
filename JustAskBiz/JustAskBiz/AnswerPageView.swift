//
//  AnswerPageView.swift
//  JustAskBiz
//
//  Created by Daniel Vaswani on 21/05/2021.
//

import SwiftUI

struct AnswerPageView: View {
    var body: some View {
        AnswerView()
    }
}
struct AnswerView: View {
    @State private var postComment = ""
    //var question: [Question]
    var body: some View {
        VStack {
            
        
            ScrollView{
                Text("This is the question")
                TagView(tags : ["tag1","tag2","tag3","tag4"])
                HStack(alignment: .top){
                    VStack{
                        Text("Asked by:")
                        HStack{
                            Image(systemName: "pencil")
                            VStack{
                                Text("John")
                                Text("Business owner")
                                Text("25k followers")
                            }
                        }
                    }
                    Spacer()
                    VStack {
                        Text("Question followed by:")
                        Image(systemName : "pencil")
                        Text("25000")
                    }
                }
                Text("May 21 2021")
                Divider()
                AnswerCardView()
                AnswerCardView()
                //AnswerCardView(answers : viewModel.answers)
                
                
                
            }
            .navigationBarTitle("Question")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button("Back"){})
            
            
            HStack(spacing : 10){
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                    
                    TextField("Sample text", text : $postComment).padding()
                }
                .frame(height: 40)
                
                
                Button(action: {}, label: {
                    Text("Post").padding(15).background(Color.blue).foregroundColor(Color.white).clipShape(RoundedRectangle(cornerRadius: 30))
                    
                })
                
                
            }.edgesIgnoringSafeArea(.bottom)
            .padding()
        }
    }
}

struct TagView: View {
    var tags : [String]
    var body : some View {
        ScrollView(.horizontal){
        HStack{
            ForEach(tags, id: \.self){ item in
                Text(item)
                    .font(.caption)
                    .padding(5)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.black, lineWidth: 1)
                    )
            }
        }
        }.padding(.horizontal, 10)
    }
}

struct AnswerCardView: View {
    //var questions : [Questions]
    var body : some View {
        ZStack {
            RoundedRectangle(cornerRadius : 15)
                .foregroundColor(Color.white)
            VStack{
                HStack(alignment : .top){
                    Image(systemName : "pencil")
                    VStack{
                        Text("Patricia")
                        Text("business owner")
                        Text("25k followers")
                    }
                    Spacer()
                    VStack{
                        Text("May 22 2021")
                           
                    }
                }.padding(5.0)
                Divider()
                Text("The answer is to do this and then to do this and then this and then this and then this. Thank you.")
                Spacer()
                
            }
            .padding([.top, .leading, .trailing], 5.0)
        }.frame(height: 200, alignment: .center)
        .shadow(radius: 5)
        .padding()
    }
}
struct AnswerPageView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerPageView()
    }
}
