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
    
    //UI variables
    @State var rotated  = false
    @State var showSaveButton = false
    @State var showDislikeButton = false
    @State var showShareButton = false
    @State var modalDisplayed = false
    
    init(recipeURLString: String){
        self.recipeViewModel.setRecipe(recipeURLString: recipeURLString)
    }

    var body: some View {
        ZStack(alignment: .topTrailing){
            //Image
            KFImage(self.recipeViewModel.recipe.imageURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .animation(Animation.spring())
                .onTapGesture {
                    self.modalDisplayed = true
                }.sheet(isPresented: self.$modalDisplayed) {
                    RecipeView(recipe:self.recipeViewModel.recipe, onDismiss: {self.modalDisplayed = false})
                }
            
            //Buttons
            VStack(alignment: .trailing) {
                //Plus button
                Button(action: {
                    self.showMenu()
                    self.rotated.toggle()
                }) {
                    Image(systemName: "plus")
                        .padding(5)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                        .rotationEffect(.degrees(self.rotated ? 90 : 0))
                        .animation(.spring())
                }
                
                //Menu drop downs
                if self.showSaveButton {
                    SaveButton(recipe: self.recipeViewModel.recipe)
                }
                if self.showDislikeButton {
                    DislikeButton(recipe: self.recipeViewModel.recipe)
                }
                if self.showShareButton {
                    ShareButton(recipe: self.recipeViewModel.recipe)
                }
            }
            .offset(x: -10, y: 10)
        }
        .padding(.vertical,10)
        .shadow(radius: 10)
    }
    
    func showMenu() {
        withAnimation {
            self.showShareButton.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            withAnimation {
                self.showDislikeButton.toggle()
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            withAnimation {
                self.showSaveButton.toggle()
            }
        })
    }
}

struct CardFromURL_Previews: PreviewProvider {
    static var previews: some View {
        CardFromURL(recipeURLString: "https://www.bonappetit.com/recipe/sour-cream-and-onion-biscuits")
    }
}


struct SaveButton: View {
    @EnvironmentObject var recipeBook: RecipeBookViewModel
    var recipe: Recipe
    
    var body: some View {
        ZStack() {
            Button(action: {
                self.recipeBook.recipes.append(self.recipe)
            }) {
            Image(systemName: "bookmark")
                .padding(10)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 2)
            }
        }
        .transition(.move(edge: .trailing))
    }
}

struct DislikeButton: View {
    @EnvironmentObject var recipeBook: RecipeBookViewModel
    var recipe: Recipe
    
    var body: some View {
        ZStack() {
            Button(action: {
                //self.recipeBook.recipes.append(self.recipe)
            }) {
            Image(systemName: "xmark")
                .padding(10)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 2)
            }
        }
        .transition(.move(edge: .trailing))
    }
}

struct ShareButton: View {
    @EnvironmentObject var recipeBook: RecipeBookViewModel
    var recipe: Recipe
    
    var body: some View {
        ZStack() {
            Button(action: {
                //self.recipeBook.recipes.append(self.recipe)
            }) {
            Image(systemName: "square.and.arrow.up.fill")
                .padding(10)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 2)
            }
        }
        .transition(.move(edge: .trailing))
    }
}
