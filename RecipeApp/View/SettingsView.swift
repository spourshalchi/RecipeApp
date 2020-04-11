//
//  SettingsView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 4/11/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct SettingsView: View {
    @EnvironmentObject var userSession: SessionStore
    
    init() {
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    
    var body: some View {
        List {
            HStack{
                Image(systemName:"bell")
                Text("Notifications")
            }
            
            Text("Hello World")
                        //Log out button
            Button(action: {
//                try! Auth.auth().signOut()
//                GIDSignIn.sharedInstance()?.signOut()
//                UserDefaults.standard.set(false, forKey: "status") //Saves the login status to persistent memory
//                
            }) {
                Text("Logout")
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
