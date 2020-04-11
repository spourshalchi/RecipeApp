//
//  CardGridFromRecipes.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/26/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage
import WaterfallGrid

struct CardGridFromRecipes: View {
    @State var modalDisplayed = false
    @EnvironmentObject var recipeBook: RecipeBookViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                WaterfallGrid(self.recipeBook.recipes) { recipe in
                    VStack{
                        //Image
                        KFImage(recipe.imageURL)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width * 0.46, height: geometry.size.height * 0.3)
                            .clipped()
                            //.clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                            .onTapGesture {
                                self.modalDisplayed = true
                            }.sheet(isPresented: self.$modalDisplayed) {
                                RecipeView(recipe:recipe, onDismiss: {self.modalDisplayed = false}).environmentObject(self.recipeBook)
                            }
                        
                        //Title
                        Text(recipe.title)
                            .font(.headline)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                    }
                    .background(Color("White"))
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .shadow(radius: 10)
                }
                .gridStyle(
                    columns: 2,
                    spacing:10,
                    padding: EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12),
                    animation: .easeInOut(duration: 0.5))
            }
        }
    }
}

struct CardGridFromRecipes_Previews: PreviewProvider {
    static var previews: some View {
        CardGridFromRecipes().environmentObject(RecipeBookViewModel())
    }
}
