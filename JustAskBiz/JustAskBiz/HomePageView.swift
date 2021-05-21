//
//  HomePageView.swift
//  JustAskBiz
//
//  Created by Daniel Vaswani on 21/05/2021.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        ScrollView{
            HStack {
                Text("What is your business interest?")
                Image(systemName: "pencil")
                
            }
            CategoryView()
        }
        
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

struct CategoryView: View {
    let colors = [Color.red, Color.blue, Color.green]
    @State private var currentColor = 0
    var body: some View {
        VStack {
            NavigationView {
                Text("Hello")
            }
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
            
        }
        
        
    }
}


struct CircleView : View {
    @State private var thepadding = false
    var text : String
    var color: Color
    
    var body : some View {
        Text(text)
            .font(.body)
            
            .foregroundColor(.white)
            
            .frame(width: 140, height: 140)
            
            .background(color)
            
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .padding(thepadding ? 10.0 : 30.0)
    }
}
