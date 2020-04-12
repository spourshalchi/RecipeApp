//
//  RecipeView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/21/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct RecipeView: View {
    //Recipe view model
    @EnvironmentObject var recipeBook: RecipeBookViewModel
    
    //UI variables
    @State var bookmarked = false
    
    let recipe: Recipe
    var onDismiss: () -> ()
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack{
                ScrollView{
                    //Bookmark
                    Button(action: {
                        self.bookmarked.toggle()
                        self.recipeBook.recipes.append(self.recipe)
                    }) {
                        Text("Bookmark")
                        Image(systemName: self.bookmarked ? "bookmark.fill" : "bookmark")
                    }
                    
                    //Image
                    KFImage(self.recipe.imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 300)
                    
                    //Title
                    Text(self.recipe.title)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .frame(width: geometry.size.width)
                        .padding()
                    
                    //Ingredients
                    VStack(spacing:20){
                        Text("Ingredients")
                            .font(.headline)
                        ForEach(self.recipe.ingredients, id: \.self) { ingredient in
                            Text(ingredient)
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .frame(width: geometry.size.width)
                        }
                    }.padding()
                    
                    //Steps
                    VStack(alignment:.leading, spacing:20){
                        Text("Steps")
                            .font(.headline)
                        ForEach(self.recipe.steps, id: \.self) { step in
                            Text(step)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                                .frame(width: geometry.size.width)
                        }
                    }.padding()
                }
                .edgesIgnoringSafeArea(.bottom)
                .offset(y:30)
            }
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: Recipe(
            recipeURLString:"https://www.bonappetit.com/recipe/charred-leeks-with-honey-and-vinegar" ,
            imageURLString:"https://assets.bonappetit.com/photos/5e6ac0e70847910008100987/3:2/w_5120,c_limit/BBaking_WEEK6_Biscuts_2.jpg",
            title:"Ramen Noodles With Spring Onions and Garlic Crisp",
            imageURL:URL(string:"https://assets.bonappetit.com/photos/5e5e818d58c694000852fc48/16:9/w_5120,c_limit/Alliums-Charred-Leeks-Honey-and-Vinegar.jpg")!,
            ingredients:["ingredint"],
            steps:["step"],
            contributor: "Molly Baz",
            publisher: "Bon Apettit"
        ), onDismiss:{})
    }
}
