//
//  CardFromURL.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/15/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import SwiftSoup
import struct Kingfisher.KFImage

struct CardFromURL: View {
    
    //Recipe view model
    @ObservedObject var recipeViewModel = RecipeViewModel()
    
    //UI variables
    @State var rotated  = false
    @State var showMenuItem1 = false
    @State var showMenuItem2 = false
    @State var showMenuItem3 = false
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
                if self.showMenuItem1 {
                    MenuItem(icon: "bookmark")
                }
                if self.showMenuItem2 {
                    MenuItem(icon: "xmark")
                }
                if self.showMenuItem3 {
                    MenuItem(icon: "square.and.arrow.up.fill")
                }
            }
            .offset(x: -10, y: 10)
        }
        .padding(.vertical,10)
        .shadow(radius: 10)
    }
    
    func showMenu() {
        withAnimation {
            self.showMenuItem3.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            withAnimation {
                self.showMenuItem2.toggle()
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            withAnimation {
                self.showMenuItem1.toggle()
            }
        })
    }
}

struct CardFromURL_Previews: PreviewProvider {
    static var previews: some View {
        CardFromURL(recipeURLString: "https://www.bonappetit.com/recipe/sour-cream-and-onion-biscuits")
    }
}


struct MenuItem: View {
    
    var icon: String
    
    var body: some View {
        ZStack() {
            Image(systemName: icon)
                .padding(10)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 2)

        }
        .transition(.move(edge: .trailing))
    }
}
