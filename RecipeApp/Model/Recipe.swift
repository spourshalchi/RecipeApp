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
    let uid: Int
    let recipeURLString: String
    let imageURLString: String
    let title: String
    let imageURL: URL
}
