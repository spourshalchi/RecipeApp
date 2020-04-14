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
    let textWidth = UIScreen.main.bounds.size.width * 0.95
    
    let recipe: Recipe
    var onDismiss: () -> ()
    
    var body: some View {
        ScrollView{
            VStack{
                ZStack(alignment: .bottomTrailing){
                    //Image
                    KFImage(self.recipe.imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.size.width)
                    
                    //Bookmark
                    Button(action: {
                        //Add only if not already in
                        if let index = self.recipeBook.recipes.firstIndex(of: self.recipe) {
                            self.recipeBook.recipes.remove(at: index)
                        } else {
                            self.recipeBook.recipes.append(self.recipe)
                        }
                    }) {
                        HStack{
                            Image(systemName: self.recipeBook.recipes.contains(recipe) ? "book.fill": "book")
                            Text(self.recipeBook.recipes.contains(recipe) ? "Unsave" : "Save").fontWeight(.bold)
                        }
                        .padding(10)
                        .background(Color.black.opacity(0.5))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .padding(7)
                    }
                }
                
                //Title
                Text(self.recipe.title)
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .frame(width: textWidth, alignment: .leading)
                
                //Contributor
                Text(self.recipe.contributor.uppercased())
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(width: textWidth, alignment: .leading)
                    .padding(.bottom, 10)
                
                //Yield
                //NOTE: Not implemented
                Text("YIELD 4 servings")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .frame(width: textWidth, alignment: .leading)
                
                //Time
                //NOTE: Not implemented
                Text("TIME 40 minutes")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .frame(width: textWidth, alignment: .leading)
                    .padding(.bottom, 12)
                
                //Cooked and review spacer
                ZStack{
                    Rectangle()
                        .fill(Color("BackgroundNeu"))
                        .frame(width: UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.width*0.1)
                    HStack{
                        HStack{
                            Text("COOKED?")
                                .foregroundColor(.gray)
                                .font(.footnote)
                                .fontWeight(.bold)
                            Image(systemName: "checkmark.circle").foregroundColor(.gray)
                        }.padding()
                        Spacer()
                        HStack{
                            Text("50")
                                .foregroundColor(.gray)
                                .font(.footnote)
                                .fontWeight(.bold)
                            Image(systemName: "star.fill").foregroundColor(.gray)
                            Image(systemName: "star.fill").foregroundColor(.gray)
                            Image(systemName: "star.fill").foregroundColor(.gray)
                            Image(systemName: "star.fill").foregroundColor(.gray)
                            Image(systemName: "star.lefthalf.fill").foregroundColor(.gray)
                        }.padding()
                    }
                }

                //Ingredients header
                Text("Ingredients".uppercased())
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(width: textWidth, alignment: .leading)
                    .padding(.bottom, 20)
                
                //Ingredients
                VStack(spacing: 15){
                    ForEach(self.recipe.ingredients, id: \.self) { ingredient in
                        Text(ingredient)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .frame(width: self.textWidth, alignment: .leading)
                    }
                    
                    //Add recipe ingredients to grocery list
                    Button(action:{
                        //
                    }) {
                        Text("Add to Your Shopping List")
                            .fontWeight(.bold)
                            .padding(10)
                            .frame(width: textWidth)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    
                    Divider()
                }.padding(.bottom, 20)
                
                //Steps header
                Text("Steps".uppercased())
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(width: textWidth, alignment: .leading)
                    .padding(.bottom, 20)
                
                //Steps
                VStack(spacing: 15){
                    ForEach(self.recipe.steps, id: \.self) { step in
                        VStack(){
                            Text("Step")
                                .font(.footnote)
                                .fontWeight(.bold)
                                .frame(width: self.textWidth, alignment: .leading)
                            Text(step)
                                .font(.footnote)
                                .frame(width: self.textWidth, alignment: .leading)
                        }
                    }
                }
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
