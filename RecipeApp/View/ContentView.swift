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
    @State var loaded: Bool = false
    @EnvironmentObject var recipeBook: RecipeBookViewModel
    @EnvironmentObject var shoppingList: ShoppingListViewModel

    
    func getUser() {
        userSession.listen()
        loaded = true
    }

    var body: some View {
        Group{
            //Loading screen while loading
            if (userSession.currentUser == nil && userSession.status){
                ActivityIndicator(shouldAnimate: true)
            }
                
            //If signed in and screen loaded
            else if (userSession.currentUser != nil){
                TabView{
                    //Discover view
                    DiscoverView().tabItem({
                        Image("meal")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:20)
                    }).tag(0)
                    
                    //Recipe book
                    RecipeBookView().tabItem({
                        Image(systemName:"book")
                    }).tag(1)
                    
                    //Shopping list
                    ShoppingListView().tabItem({
                        Image(systemName:"list.bullet")
                    }).tag(1)
                    
                    //Profile
                    NavigationView{
                        ProfileView()
                    }
                    .tabItem({
                        Image(systemName:"person.crop.circle.fill")
                    }).tag(1)
                }.accentColor(Color.red)
                .environmentObject(recipeBook)
                .environmentObject(shoppingList)
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
