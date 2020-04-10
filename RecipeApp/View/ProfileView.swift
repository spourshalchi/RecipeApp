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
import struct Kingfisher.KFImage

struct ProfileView: View {
    @EnvironmentObject var userSession: SessionStore
    
    var body: some View {
        VStack(){
            
            KFImage(URL(string: (userSession.currentUser?.photoURL)!))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: UIScreen.main.bounds.size.width * 0.5)
                .overlay(Circle().stroke(Color.white,lineWidth:4)
                .shadow(radius: 10))

            Text((userSession.currentUser?.displayName)!)
                .font(.largeTitle)
            
            HStack(){
                Text("\((userSession.currentUser?.followers.count)!) followers")
                Text("\((userSession.currentUser?.following.count)!) following")
            }.padding()

            Button(action: {
                try! Auth.auth().signOut()
                GIDSignIn.sharedInstance()?.signOut()
                UserDefaults.standard.set(false, forKey: "status") //Saves the login status to persistent memory
                
            }) {
                Text("Logout")
            }
            
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(SessionStore())
    }
}
