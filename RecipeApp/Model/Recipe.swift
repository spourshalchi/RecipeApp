//
//  Recipe.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/19/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI

struct Recipe: Identifiable, Codable, Equatable {
    let id = UUID()
    var recipeURLString: String
    var imageURLString: String
    var title: String
    var imageURL: URL!
    var ingredients:[String]
    var steps:[String]
    var contributor: String
    var publisher: String
    
    static func ==(lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.recipeURLString == rhs.recipeURLString
    }
}
