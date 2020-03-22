//
//  ContentView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/15/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView{
            DiscoverView().tabItem({
                Image(systemName:"flame")
            }).tag(0)
            
            RecipeBookView().tabItem({
                Image(systemName:"book")
            }).tag(1)
            
            IngredientListView().tabItem({
                Image(systemName:"list.bullet")
            }).tag(1)
            
            ProfileView().tabItem({
                Image(systemName:"person.crop.circle.fill")
            }).tag(1)
        }.accentColor(Color.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
