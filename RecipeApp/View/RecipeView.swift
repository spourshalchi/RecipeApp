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
    let recipe: Recipe
    var onDismiss: () -> ()
    
    var body: some View {
        VStack{
            Text(recipe.title)
                .font(.headline)
                .padding()
            KFImage(recipe.imageURL)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 300)
            Spacer()
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: Recipe(uid: 0, recipeURLString:"https://www.bonappetit.com/recipe/charred-leeks-with-honey-and-vinegar" , imageURLString:"https://assets.bonappetit.com/photos/5e6ac0e70847910008100987/3:2/w_5120,c_limit/BBaking_WEEK6_Biscuts_2.jpg",title:"Charred Leeks With Honey and Vinegar", imageURL:URL(string:"https://assets.bonappetit.com/photos/5e5e818d58c694000852fc48/16:9/w_5120,c_limit/Alliums-Charred-Leeks-Honey-and-Vinegar.jpg")!), onDismiss:{})
    }
}
