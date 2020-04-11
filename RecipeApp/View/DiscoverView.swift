//
//  DiscoverView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/19/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI

struct DiscoverView: View {
    @State private var following = false
    
    let links: [String] = ["https://www.bonappetit.com/recipe/green-garlic-roast-chicken", "https://www.bonappetit.com/recipe/fusilli-with-battuto-di-erbe", "https://www.bonappetit.com/recipe/digestive-cookies", "https://www.bonappetit.com/recipe/rigatoni-with-fennel-and-anchovies",
        "https://www.bonappetit.com/recipe/pork-and-asparagus-stir-fry",
        "https://www.bonappetit.com/recipe/ramen-noodles-with-spring-onions"]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
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
                        .foregroundColor(following ? Color("Black") : Color("White"))
                        .background(following ? Color("White") : Color("Black"))
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
                        .foregroundColor(following ? Color("White") : Color("Black"))
                        .background(following ? Color("Black") : Color("White"))
                        .cornerRadius(40)
                    }
                }
                
                //Cards
                VStack(){
                    ForEach(0 ..< links.count) {
                        CardFromURL(recipeURLString: self.links[$0])
                    }
                }
            }
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
