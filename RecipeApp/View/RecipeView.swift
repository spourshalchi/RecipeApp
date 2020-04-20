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
    @EnvironmentObject var shoppingList: ShoppingListViewModel
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
                            //Add recipe to recipe book
                            self.recipeBook.recipes.append(self.recipe)
                        }
                        //THIS CODE IS NEEDED BECAUSE OF A BUG IN SWIFT 5.2 AND SHOULD BE RESOLVED IN THE NEXT VERSION https://bugs.swift.org/browse/SR-12089
                        var newRecipes = [Recipe]() //new temporary array
                        for recipeInBook in self.recipeBook.recipes {
                            newRecipes.append(recipeInBook) //copy class array to temp array
                        }
                        self.recipeBook.recipes = newRecipes
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
                if (self.recipe.yield != "")  {
                    Text(self.recipe.yield)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .frame(width: textWidth, alignment: .leading)
                }
                
                //Time
                if (self.recipe.timeToMake != "") {
                    Text(self.recipe.timeToMake)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .frame(width: textWidth, alignment: .leading)
                        .padding(.bottom, 12)
                }
                
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
                        if(self.recipe.numRatings != 0) {
                            HStack{
                                Text("\(self.recipe.numRatings)")
                                    .foregroundColor(Color("Black"))
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                StarRating(rating: self.recipe.avgRating)
                            }.padding()
                        } else {
                            Text("No ratings yet")
                                .foregroundColor(.gray)
                                .font(.footnote)
                                .fontWeight(.bold)
                                .padding()
                        }
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
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: self.textWidth, alignment: .leading)
                    }
                    
                    //Add recipe ingredients to grocery list
                    Button(action:{
                        
                        //Add only if not already in
                        if self.shoppingList.shoppingList.firstIndex(of: ShoppingListItem(recipe: self.recipe)) == nil {
                            //Add to shopping list
                            self.shoppingList.shoppingList.append(ShoppingListItem(recipe: self.recipe))
                        }
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

struct StarRating : View {
    @State var rating : Float
    
    var body : some View {
        HStack{
            ForEach(1 ... Int(floor(self.rating)), id: \.self) { number in
                Image(systemName: "star.fill").foregroundColor(Color("Gold"))
            }
            //0.5
            if(rating-floor(self.rating) > 0.25 && rating-floor(self.rating) < 0.75) {
                Image(systemName: "star.lefthalf.fill").foregroundColor(Color("Gold"))
            }
            //Round up
            else if(rating-floor(self.rating) >= 0.75 ) {
                Image(systemName: "star.fill").foregroundColor(Color("Gold"))
            }
        }
    }
}

struct StarRating_Previews: PreviewProvider {
    static var previews: some View {
        StarRating(rating: 3.3)
    }
}
