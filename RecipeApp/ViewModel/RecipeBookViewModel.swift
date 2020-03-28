//
//  RecipesViewModel.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/19/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI


class RecipeBookViewModel: ObservableObject {
    @Published var recipes: [Recipe] = [
        Recipe(uid: 0, recipeURLString:"https://www.bonappetit.com/recipe/sour-cream-and-onion-biscuits" , imageURLString:"https://assets.bonappetit.com/photos/5e6ac0e70847910008100987/3:2/w_5120,c_limit/BBaking_WEEK6_Biscuts_2.jpg",title:"Sour Cream and Onion Biscuits", imageURL:URL(string: "https://assets.bonappetit.com/photos/5e6ac0e70847910008100987/3:2/w_5120,c_limit/BBaking_WEEK6_Biscuts_2.jpg")!,ingredients:["ingredint"],steps:["step"]),
        Recipe(uid: 0, recipeURLString:"https://www.bonappetit.com/recipe/sour-cream-and-onion-biscuits" , imageURLString:"https://assets.bonappetit.com/photos/5e6ac0e70847910008100987/3:2/w_5120,c_limit/BBaking_WEEK6_Biscuts_2.jpg",title:"Sour Cream and Onion Biscuits", imageURL:URL(string: "https://assets.bonappetit.com/photos/5e6ac0e70847910008100987/3:2/w_5120,c_limit/BBaking_WEEK6_Biscuts_2.jpg")!,ingredients:["ingredint"],steps:["step"]),
        Recipe(uid: 0, recipeURLString:"https://www.bonappetit.com/recipe/sour-cream-and-onion-biscuits" , imageURLString:"https://assets.bonappetit.com/photos/5e6ac0e70847910008100987/3:2/w_5120,c_limit/BBaking_WEEK6_Biscuts_2.jpg",title:"Sour Cream and Onion Biscuits", imageURL:URL(string: "https://assets.bonappetit.com/photos/5e6ac0e70847910008100987/3:2/w_5120,c_limit/BBaking_WEEK6_Biscuts_2.jpg")!,ingredients:["ingredint"],steps:["step"]),
        Recipe(uid: 0, recipeURLString:"https://www.bonappetit.com/recipe/sour-cream-and-onion-biscuits" , imageURLString:"https://assets.bonappetit.com/photos/5e6ac0e70847910008100987/3:2/w_5120,c_limit/BBaking_WEEK6_Biscuts_2.jpg",title:"Sour Cream and Onion Biscuits", imageURL:URL(string: "https://assets.bonappetit.com/photos/5e6ac0e70847910008100987/3:2/w_5120,c_limit/BBaking_WEEK6_Biscuts_2.jpg")!,ingredients:["ingredint"],steps:["step"])
    ]
}

