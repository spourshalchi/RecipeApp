//
//  ShoppingListView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/21/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI

struct ShoppingListView: View {
    @State var hasShoppingList = false
    @EnvironmentObject var recipeBook: RecipeBookViewModel

    var body: some View {
        VStack{
            Text("Tap to create a new shopping list")
                .font(.subheadline)
            Button(action: {
                self.hasShoppingList.toggle()
            }) {
                Image(systemName: "square.and.pencil")
            }.sheet(isPresented: $hasShoppingList) {
                //CardGridFromRecipes().environmentObject(self.recipeBook)
                Text("To Do: implement pick recipes")
            }
        }
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}

struct PickRecipesView: View {
    var body: some View {
        Text("Pick recipes from recipe book here")
    }
}
