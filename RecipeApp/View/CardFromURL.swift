//
//  CardFromURL.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/15/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct CardFromURL: View {
    
    //Recipe view model
    @ObservedObject var recipeViewModel = RecipeViewModel()
    @EnvironmentObject var recipeBook: RecipeBookViewModel
    
    //UI variables
    @State var modalDisplayed = false
    @State var bookmarked = false
    
    init(recipeURLString: String){
        self.recipeViewModel.setRecipe(recipeURLString: recipeURLString)
    }

    var body: some View {
        VStack(alignment: .leading){
            ZStack(alignment: .topTrailing){
                //Image
                KFImage(self.recipeViewModel.recipe.imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400)
                    .clipped()
                    .onTapGesture {
                        self.modalDisplayed = true
                    }.sheet(isPresented: self.$modalDisplayed) {
                        RecipeView(recipe:self.recipeViewModel.recipe, onDismiss: {self.modalDisplayed = false}).environmentObject(self.recipeBook)
                    }

                    //Bookmark
                    Button(action: {
                        self.bookmarked.toggle()
                        self.recipeBook.recipes.append(self.recipeViewModel.recipe)
                    }) {
                        Image(systemName: bookmarked ? "bookmark.fill" : "bookmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .foregroundColor(bookmarked ? .red : .white)
                    }
                    .offset(x: -20)
                    .buttonStyle(PlainButtonStyle())
            }
            Text(self.recipeViewModel.recipe.title)
                .font(.headline)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
            
        }
        .background(Color.white)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .shadow(radius: 10)
        
        //Context menu
        .contextMenu {
            //Bookmark
            Button(action: {
                self.bookmarked.toggle()
                self.recipeBook.recipes.append(self.recipeViewModel.recipe)
            }) {
                Text("Bookmark")
                Image(systemName: "bookmark")
            }
            
            //Less like this
            Button(action: {
              // copy the content to the paste board
            }) {
                Text("Less like this")
                Image(systemName: "xmark")
            }
            
            //Share
            Button(action: {
              // copy the content to the paste board
            }) {
                Text("Share")
                Image(systemName: "square.and.arrow.up.fill")
            }
        }
    }
}

struct CardFromURL_Previews: PreviewProvider {
    static var previews: some View {
        CardFromURL(recipeURLString: "https://www.bonappetit.com/recipe/sour-cream-and-onion-biscuits")
    }
}
