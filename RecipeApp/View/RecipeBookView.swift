//
//  RecipeBookView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/19/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct RecipeBookView: View {
    @EnvironmentObject var recipeBook: RecipeBookViewModel
    @EnvironmentObject var shoppingList: ShoppingListViewModel
    @EnvironmentObject var userSession: SessionStore
    
    init() {
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().separatorStyle = .none
      }
    
    var body: some View {
            NavigationView {
                VStack {
                    List(recipeBook.recipes) { recipe in
                        NavigationLink(destination: RecipeView(recipe:recipe, onDismiss:{}).environmentObject(self.userSession)) {
                            HStack(){
                                //Image
                                KFImage(recipe.imageURL)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .clipped()
                                
                                //Text
                                Text(recipe.title)
                                Spacer()
                            }.padding(.leading,5)
                        }
                    }
            }.navigationBarTitle(Text("Recipe Book"), displayMode: .inline)
        }
    }
}

struct RecipeBookView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeBookView()
    }
}
