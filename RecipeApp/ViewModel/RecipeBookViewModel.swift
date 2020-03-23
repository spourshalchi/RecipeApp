//
//  RecipesViewModel.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/19/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI


class RecipeBookViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    
    func fetchRecipes() {
        self.recipes = [
            Recipe(uid: 0, recipeURLString:"https://www.bonappetit.com/recipe/sour-cream-and-onion-biscuits" , imageURLString:"https://assets.bonappetit.com/photos/5e6ac0e70847910008100987/3:2/w_5120,c_limit/BBaking_WEEK6_Biscuts_2.jpg",title:"Sour Cream and Onion Biscuits", imageURL:URL(string: "https://assets.bonappetit.com/photos/5e6ac0e70847910008100987/3:2/w_5120,c_limit/BBaking_WEEK6_Biscuts_2.jpg")!,ingredients:["ingredint"],steps:["step"]),
            Recipe(uid: 0, recipeURLString:"https://www.bonappetit.com/recipe/charred-leeks-with-honey-and-vinegar" , imageURLString:"https://assets.bonappetit.com/photos/5e6ac0e70847910008100987/3:2/w_5120,c_limit/BBaking_WEEK6_Biscuts_2.jpg",title:"Charred Leeks With Honey and Vinegar", imageURL:URL(string:"https://assets.bonappetit.com/photos/5e5e818d58c694000852fc48/16:9/w_5120,c_limit/Alliums-Charred-Leeks-Honey-and-Vinegar.jpg")!,ingredients:["ingredint"],steps:["step"])
        ]
    }
}

