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
            if (userSession.currentUser != nil) {
                //Profile picture
                KFImage(URL(string: (userSession.currentUser?.photoURL)!))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: UIScreen.main.bounds.size.width * 0.5)
                    .overlay(Circle().stroke(Color("White"),lineWidth:4)
                    .shadow(radius: 10))
                    .padding()

                //Display name
                Text((userSession.currentUser?.displayName)!)
                    .font(.largeTitle)
                
                //Followers and following
                HStack(){
                    Text("\((userSession.currentUser?.followers.count)!) followers")
                    Text("\((userSession.currentUser?.following.count)!) following")
                }.padding()
            }
            Spacer()
        }
        .navigationBarItems(
            leading:
                Button(action: {
                    print("Messages here")
                }) {
                    Image(systemName: "paperplane")
                },
            trailing:
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                }
        )
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(SessionStore())
    }
}
