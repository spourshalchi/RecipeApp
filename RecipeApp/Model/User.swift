//
//  User.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/29/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import Foundation

struct User {
    var uid: String
    var email: String?
    var displayName: String?
    var photoURL: String?
    var followers: [String]
    var following: [String]
    var recipeBook: [String]
    var signUpMethod: String?
    
    
    init(uid: String, displayName: String?, email: String?, photoURL: String?, followers:[String], following: [String], recipeBook: [String], signUpMethod: String? ) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.photoURL = photoURL
        self.followers = followers
        self.following = following
        self.recipeBook = recipeBook
        self.signUpMethod = signUpMethod
    }
}
