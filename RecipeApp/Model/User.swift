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
    
    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}
