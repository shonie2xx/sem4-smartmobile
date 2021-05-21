//
//  ProfilePageView.swift
//  JustAskBiz
//
//  Created by Daniel Vaswani on 21/05/2021.
//

import SwiftUI

struct ProfilePageView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 15){
                
                Image(systemName : "pencil")
                    .renderingMode(.original)
                    .resizable(capInsets: EdgeInsets(top: 7.0, leading: 6.0, bottom: 8.0, trailing: 9.0), resizingMode: .tile)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60.0, height: 60.0)
                Text("Simon Mayorov")
                Text("Young Business Owner")
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Edit profile")
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    
                })
                Divider()
                InfoCardView(titleText: "About me", descText: "The quick brown fox jumps over the lazy dog diuwhiuhweiuhdiueuehfiwuhfhewiu")
                InfoCardView(titleText: "Industry", descText: "The quick brown fox jumps over the lazy dog diuwhiuhweiuhdiueuehfiwuhfhewiu ")
                InfoCardView(titleText: "Contact", descText: "The quick brown fox jumps over the lazy dog diuwhiuhweiuhdiueuehfiwuhfhewiu ")
                Spacer()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back"){
                        
                    }
                }
            }
            .padding()
        }
        
    }
}

struct InfoCardView : View{
    var titleText : String
    var descText : String
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.white)
                .shadow(radius: 1)
            VStack(spacing: 10) {
                Text(titleText)
                    .font(.headline)
                HStack{
                    Text(descText)
                        .font(.footnote)
                    Spacer()
                }
                Spacer()
            }.padding(10)
        }.frame(height:120)
        .padding()
    }
}
struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}
