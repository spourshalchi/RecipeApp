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
    @EnvironmentObject var userSettings: UserSettingsSession
    
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
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .padding(.horizontal)
                Text("Notifications")
            }
            
            NavigationLink(destination: DarkModeView()) {
                HStack{
                    Image(systemName: "moon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .padding(.horizontal)
                    Text("Dark Mode")
                }
            }
            
            HStack{
                Image(systemName:"questionmark.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .padding(.horizontal)
                Text("Help")
            }

            HStack{
                Image(systemName:"info.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .padding(.horizontal)
                Text("About")
            }
            
            
            //Log out button
            Button(action: {
                try! Auth.auth().signOut()
                GIDSignIn.sharedInstance()?.signOut()
                UserDefaults.standard.set(false, forKey: "status") //Saves the login status to persistent memory
                
            }) {
                Text("Logout \((userSession.currentUser?.displayName ?? ""))")
                    .foregroundColor(.accentColor)
                    .padding(.horizontal)
            }
        }
        .navigationBarTitle("Settings", displayMode: .inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(SessionStore())
    }
}


struct DarkModeView: View {
    @EnvironmentObject var userSettingsSession: UserSettingsSession

    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Dark mode").bold()
            
            Picker(
                selection: $userSettingsSession.userSettings.darkModePreference,
                label: Text("Dark mode")
            ){
                ForEach(UserSettings.DarkModePreference.allCases, id: \.self) { pref in
                    Text(pref.rawValue).tag(pref)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            if($userSettingsSession.userSettings.darkModePreference.wrappedValue == .system){
                Text("Use your device's system appearance setting for light mode, dark mode, or automatic theming.").foregroundColor(.gray).font(.footnote)
            }
            else if ($userSettingsSession.userSettings.darkModePreference.wrappedValue == .on){
                Text("Dark mode is always on. CURRENTLY UNSUPPORTED").foregroundColor(.gray).font(.footnote)
            } else {
                Text("Dark mode is always off. CURRENTLY UNSUPPORTED").foregroundColor(.gray).font(.footnote)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(Text("Appearance"))
    }
}
