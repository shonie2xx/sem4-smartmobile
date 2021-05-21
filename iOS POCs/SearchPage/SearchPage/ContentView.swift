//
//  ContentView.swift
//  SearchPage
//
//  Created by Daniel Vaswani on 21/05/2021.
//

import SwiftUI
struct ContentView: View {
    
    var body: some View {
        SearchView()
    }
    
}
struct SearchView: View {
    @State var tagString : String = ""
    
    func handleButtonTap(){
        
    }
    var body: some View {
        NavigationView{
            VStack{
                TagView(text : ["Business","Marketing","VC","Funding"])
            }
            .navigationTitle("Search").navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Back"){
                        
                    }
                }
            })
        }
    }
}

struct TagView: View {
    var text : [String]
    @State private var tagString : String = ""
    var body : some View {
        HStack {
            Image(systemName : "pencil")
                .padding()
            VStack(alignment: .leading){
                Text("Tags")
                TextField("Enter tags", text : $tagString)
            }.padding()
            
        }
        
        
        HStack{
            ForEach(text, id: \.self){ item in
                Button(action: {tagString += " \(item)"}, label: {
                    Text(item)
                        .font(.caption)
                        .padding(5)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.black, lineWidth: 0.5)
                        )
                })
                
            }
        }
        Button(action : {} , label : {
            Text("Done")
        })
        
        Spacer()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
