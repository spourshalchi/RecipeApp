//
//  RecipesViewModel.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/19/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI


class RecipeBookViewModel: ObservableObject {
    @Published var recipes: [Recipe] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(recipes) {
                UserDefaults.standard.set(encoded, forKey: "RecipeBook")
            } else {
                print("ERROR: Recipe wasn't saved to UserDefaults")
            }
        }
    }
    
    init() {
        if let recipes = UserDefaults.standard.data(forKey: "RecipeBook")
        {
            let decoder = JSONDecoder()
            
            if let decoded = try?
                decoder.decode([Recipe].self,from:recipes) {
                self.recipes = decoded
                return
            }
            print("Couldnt decode data from User Defaults")
        }
        print("Didn't load any recipes from User Defaults")
        
        //If no saved recipes yet
        self.recipes = []
    }
}

