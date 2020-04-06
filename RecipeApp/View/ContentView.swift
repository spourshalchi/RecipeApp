//
//  ContentView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/15/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userSession: SessionStore
    
    func getUser() {
        userSession.listen()
    }
    
    var recipeBook = RecipeBookViewModel()

    var body: some View {
        Group{
            //If signed in
            if (userSession.currentUser != nil){
                TabView{
                    DiscoverView().tabItem({
                        Image("meal")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:20)
                    }).tag(0)
                    
                    RecipeBookView().tabItem({
                        Image(systemName:"book")
                    }).tag(1)
                    
                    ShoppingListView().tabItem({
                        Image(systemName:"list.bullet")
                    }).tag(1)
                    
                    ProfileView().tabItem({
                        Image(systemName:"person.crop.circle.fill")
                    }).tag(1)
                }.accentColor(Color.red)
                .environmentObject(recipeBook)
            }
            
            else{
                WelcomeView()
            }
        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}
