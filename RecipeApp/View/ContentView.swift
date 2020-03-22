//
//  ContentView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/15/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter

    func containedView() -> AnyView {
        switch viewRouter.currentPage {
        case "Discover": return AnyView(DiscoverView())
        case "RecipeBook": return AnyView(RecipeBookView())
        case "IngredientList": return AnyView(IngredientListView())
        case "Profile": return AnyView(ProfileView())
        default:
            return AnyView(DiscoverView())
        }
    }
    
    var body: some View {
        ZStack {
            containedView()
            VStack(){
                Spacer()
                BottomBar()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
