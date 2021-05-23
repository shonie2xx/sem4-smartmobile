//
//  HomePageView.swift
//  JustAskBiz
//
//  Created by Daniel Vaswani on 21/05/2021.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    HStack {
                        Text("What is your business interest?")
                        Image(systemName: "pencil")
                    }
                    CategoryView()
                }
            }.navigationTitle("Categories")
        }
        
        
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

struct CategoryView: View {
    let tags = ["Leadership", "Funding","Soft Skills", "Legal Issues", "Technology",
    "Marketing", "Modernization"]
    
    let colors = [Color.red, Color.blue, Color.green]
    @State private var tagNumber = 0
    @State private var currentColor = 0
    var body: some View {
        VStack {
//            ForEach(0..< tags.count, id : \.self){
//                //tag , tag + 1
//                //tag spacer Spacer()
//                HStack{
//                    CircleView(text : "\(tags[$0])", color: Color.red)
//                }
//            }
            HStack{
                CircleView(text : "Leadership", color: Color.red).padding([.leading, .bottom], 50.0)
                CircleView(text : "Funding", color: Color.green)
            }
            HStack{
                CircleView(text : "Soft Skills", color : Color.blue)
                    .padding([.top, .trailing], 34.0)
                    
                CircleView(text : "Leadership", color: Color.red)
            }
            
            
            HStack{
                CircleView(text : "Legal Issues", color: Color.green)
                CircleView(text : "Technology", color : Color.blue)
            }
            HStack{
                CircleView(text : "Marketing", color: Color.red)
                CircleView(text : "Modernization", color: Color.green)
            }
//            HStack{
//                Button(action:{
//                    
//                }, label: Text("Idi na hui blyat"))
//            }
        }
    }
}


struct CircleView : View {
    @State private var thepadding = false
    var text : String
    var color: Color
    
    var body : some View {
        NavigationLink(
            destination: QuestionsPageView(tags : [text]),
            label: {
//                Button(action: { /* NavigationLink Text "Categories" destination
//                        QuestionsPageView and then tell the viewModel to update questions list*/
//
//                         }, label: {
//
//                })
                Text(text)
                    .font(.body)
                    
                    .foregroundColor(.white)
                    
                    .frame(width: 140, height: 140)
                    
                    .background(color)
                    
                    .clipShape(Circle())
            })
        
        
    }
}
