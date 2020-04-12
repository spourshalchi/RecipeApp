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
}

