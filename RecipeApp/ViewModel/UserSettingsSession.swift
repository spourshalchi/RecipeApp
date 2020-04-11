//
//  UserSettingsSession.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 4/11/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import Foundation
import SwiftUI

class UserSettingsSession: ObservableObject {
    @Published var userSettings = UserSettings()
}

struct UserSettings {
    var prefersNotifications: Bool
    var darkModePreference: DarkModePreference
    
    enum DarkModePreference: String, CaseIterable {
        case on = "On"
        case off = "Off"
        case system = "System Setting"
    }
    
    init(prefersNotifications: Bool = true, darkModePreference: DarkModePreference = .system) {
        self.prefersNotifications = prefersNotifications
        self.darkModePreference = darkModePreference
    }
}
