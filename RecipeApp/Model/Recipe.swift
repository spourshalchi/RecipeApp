//
//  Recipe.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/19/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI

struct Recipe: Decodable, Identifiable {
    let id = UUID()
    var uid: Int
    var recipeURLString: String
    var imageURLString: String
    var title: String
    var imageURL: URL!
    var ingredients:[String]
    var steps:[String]
}
