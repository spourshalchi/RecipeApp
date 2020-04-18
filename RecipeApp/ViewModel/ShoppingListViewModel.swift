//
//  ShoppingListViewModel.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 4/17/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI


class ShoppingListViewModel: ObservableObject {
    @Published var shoppingList: [ShoppingListItem] = []
}


struct ShoppingListItem: Identifiable, Codable, Equatable {
    var id = UUID()
    var recipe: Recipe
    var show:Bool = true
    
    static func ==(lhs: ShoppingListItem, rhs: ShoppingListItem) -> Bool {
        return lhs.recipe == rhs.recipe
    }
}
