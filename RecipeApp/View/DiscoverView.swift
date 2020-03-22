//
//  DiscoverView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/19/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var following = false
    
    let links: [String] = ["https://www.bonappetit.com/recipe/green-garlic-roast-chicken", "https://www.bonappetit.com/recipe/fusilli-with-battuto-di-erbe", "https://www.bonappetit.com/recipe/charred-leeks-with-honey-and-vinegar", "https://www.bonappetit.com/recipe/rigatoni-with-fennel-and-anchovies",
        "https://www.bonappetit.com/recipe/pork-and-asparagus-stir-fry",
        "https://www.bonappetit.com/recipe/ramen-noodles-with-spring-onions"]
    
    var body: some View {
        VStack {
            //For you/following Buttons
            HStack(){
                //For you button
                Button(action: {
                    self.following = false
                }) {
                    HStack {
                        Text("For you")
                            .fontWeight(.semibold)
                            .font(.body)
                    }
                    .padding()
                    .foregroundColor(following ? .black : .white)
                    .background(following ? Color.white : Color.black)
                    .cornerRadius(40)
                }
                
                //Following button
                Button(action: {
                    self.following = true
                }) {
                    HStack {
                        Text("Following")
                            .fontWeight(.semibold)
                            .font(.body)
                    }
                    .padding()
                    .foregroundColor(following ? .white : .black)
                    .background(following ? Color.black : Color.white)
                    .cornerRadius(40)
                }
            }
            
            //Cards
            ScrollView{
                HStack(){
                    VStack(){
                        ForEach(0 ..< links.count/2) {
                            CardFromURL(recipeURLString: self.links[$0])
                        }
                    }
                    VStack(){
                        ForEach(links.count/2 ..< links.count) {
                            CardFromURL(recipeURLString: self.links[$0])
                        }
                    }
                }
            }
            .offset(y: -15)
            .padding()
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
