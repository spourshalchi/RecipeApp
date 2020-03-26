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

    
    init() {
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().separatorStyle = .none
      }
    
    var body: some View {
            NavigationView {
                VStack {
                    List(recipeBook.recipes) { recipe in
                        NavigationLink(destination: RecipeView(recipe:recipe, onDismiss:{})) {
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
                            }.padding(.leading,10)
                        }
                    }
            }.navigationBarTitle(Text("Recipe Book"), displayMode: .inline)
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct RecipeBookView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeBookView()
    }
}
