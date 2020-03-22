//
//  BottomBar.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/15/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI

struct BottomBar: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        
        HStack(){
            Button(action: { self.viewRouter.currentPage != "Discover" ? (self.viewRouter.currentPage = "Discover") : ()}) {
                    Image("pot")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30.0)
                        .padding()
                        .foregroundColor(self.viewRouter.currentPage != "Discover" ? .gray : .black)
            }
            
            Button(action: { self.viewRouter.currentPage != "RecipeBook" ? (self.viewRouter.currentPage = "RecipeBook") : ()}) {
                    Image("book")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30.0)
                    .padding()
                    .foregroundColor(self.viewRouter.currentPage != "RecipeBook" ? .gray : .black)
            }
            Button(action: { self.viewRouter.currentPage != "IngredientList" ? (self.viewRouter.currentPage = "IngredientList") : ()}) {
                    Image("list")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30.0)
                    .padding()
                    .foregroundColor(self.viewRouter.currentPage != "IngredientList" ? .gray : .black)
            }
            Button(action: { self.viewRouter.currentPage != "Profile" ? (self.viewRouter.currentPage = "Profile") : ()}) {
                    Image("user")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30.0)
                    .padding()
                    .foregroundColor(self.viewRouter.currentPage != "Profile" ? .gray : .black)
            }
        }

        .foregroundColor(.gray)
        .background(Color.white)
        .cornerRadius(60)
        .shadow(radius: 10)
    }
}

struct BottomBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomBar()
    }
}
