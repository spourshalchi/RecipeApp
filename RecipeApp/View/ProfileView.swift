//
//  ProfileView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/21/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct ProfileView: View {
    @EnvironmentObject var session: SessionStore
    
    let followers = 0
    let following = 1
    
    var body: some View {
        VStack(){
            Image(systemName:"person.fill")
            
            Text("Display Name")
                .font(.largeTitle)
            
            HStack(){
                Text("\(followers) followers")
                Text("\(following) following")
            }.padding()

            Button(action: {
                try! Auth.auth().signOut()
                GIDSignIn.sharedInstance()?.signOut()
                UserDefaults.standard.set(false, forKey: "status") //Saves the login status to persistent memory
                //NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                
            }) {
                Text("Logout")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(SessionStore())
    }
}
