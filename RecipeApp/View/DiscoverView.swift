//
//  DiscoverView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/19/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import struct Kingfisher.KFImage

struct DiscoverView: View {
    @State private var following = false
    @State var loadedRecipes: [Recipe] = []
    let db = Firestore.firestore()
    @State var lastSnapshot: QueryDocumentSnapshot?
    @EnvironmentObject var recipeBook: RecipeBookViewModel
    @State var modalDisplayed = false
    
    var body: some View {
        
        ScrollView{
            VStack {
                //For you/following Buttons
                HStack(){
                    //For you button
                    Button(action: {
                        self.following = false
                    }) {
                        HStack {
                            Text("For you")
                                .fontWeight(.semibold)
                                .font(.body)
                        }
                        .padding()
                        .foregroundColor(following ? Color("Black") : Color("White"))
                        .background(following ? Color("White") : Color("Black"))
                        .cornerRadius(40)
                    }
                    
                    //Following button
                    Button(action: {
                        self.following = true
                    }) {
                        HStack {
                            Text("Following")
                                .fontWeight(.semibold)
                                .font(.body)
                        }
                        .padding()
                        .foregroundColor(following ? Color("White") : Color("Black"))
                        .background(following ? Color("Black") : Color("White"))
                        .cornerRadius(40)
                    }
                }
                
                //Cards
                if(loadedRecipes.count > 0){
                    ForEach(loadedRecipes) { recipe in
                        VStack{
                            ZStack(alignment: .topTrailing){
                                KFImage(recipe.imageURL)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.size.width * 0.9)
                                    .clipped()
                                
//                                //Bookmark
//                                Button(action: {
//                                    self.recipeBook.recipes.append(recipe)
//                                }) {
//                                    Image(systemName: "bookmark.fill")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(width: 30)
//                                        .foregroundColor(.red)
//                                }
//                                .offset(x: -20)
//                                .buttonStyle(PlainButtonStyle())
                            }
                            
                            Text(recipe.title)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .frame(width: UIScreen.main.bounds.size.width * 0.9)
                                .padding(.bottom, 10)
                        }
                            .background(Color("White"))
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                            .shadow(radius: 5)
                            
                            //Context menu
                            .contextMenu {
                                //Bookmark
                                Button(action: {
                                    //Add only if not already in
                                    if let index = self.recipeBook.recipes.firstIndex(of: recipe) {
                                        self.recipeBook.recipes.remove(at: index)
                                    } else {
                                        self.recipeBook.recipes.append(recipe)
                                    }
                                }) {
                                    Text(self.recipeBook.recipes.contains(recipe) ? "Unsave from recipe book" : "Save to recipe book").multilineTextAlignment(.center)
                                    Image(systemName: self.recipeBook.recipes.contains(recipe) ? "book.fill": "book")
                                }
                                
//                                //Less like this
//                                Button(action: {
//                                  // copy the content to the paste board
//                                }) {
//                                    Text("Less like this")
//                                    Image(systemName: "xmark")
//                                }
                                
//                                //Share
//                                Button(action: {
//                                  // copy the content to the paste board
//                                }) {
//                                    Text("Share")
//                                    Image(systemName: "square.and.arrow.up.fill")
//                                }
                            }
                        }
                }
                
                Button(action:loadMoreRecieps){
                    Image(systemName:"arrow.down.circle.fill")
                    .padding(.bottom, 15)
                }
            }.frame(width: UIScreen.main.bounds.size.width)
        }
        .onAppear {
            if(self.loadedRecipes.count == 0) {
                self.loadFirstRecipes()
            }
        }
    }
    
    func loadFirstRecipes(){
        //First query
        let first = self.db.collection("recipes")
            .order(by: "title")
            .limit(to: 10)
        
        first.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error retreving recipes: \(error.debugDescription)")
                return
            }

            //Update last snapshot variable
            self.lastSnapshot = snapshot.documents.last

            //Print first query results
            for document in snapshot.documents {
                //Add to loaded recipes
                self.loadedRecipes.append(Recipe(
                    recipeURLString: (document.data()["recipeURLString"] as! String),
                    imageURLString: (document.data()["imageURLString"] as! String),
                    title: (document.data()["title"] as! String),
                    imageURL: URL(string: (document.data()["imageURLString"] as! String)),
                    ingredients: (document.data()["ingredients"] as? [String] ?? []),
                    steps: (document.data()["steps"] as? [String] ?? []),
                    contributor: (document.data()["contributor"] as! String),
                    publisher: (document.data()["publisher"] as! String)
                ))
            }
        }
    }
    
    func loadMoreRecieps(){
        //Start from where last query left off
        let next = self.db.collection("recipes")
            .order(by: "title")
            .start(afterDocument: self.lastSnapshot!)
            .limit(to: 10)
        
        next.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error retreving recipes: \(error.debugDescription)")
                return
            }
            
            //Update last snapshot variable
            self.lastSnapshot = snapshot.documents.last
            
            //Print first query results
            for document in snapshot.documents {
                //Add to loaded recipes
                self.loadedRecipes.append(Recipe(
                    recipeURLString: (document.data()["recipeURLString"] as! String),
                    imageURLString: (document.data()["imageURLString"] as! String),
                    title: (document.data()["title"] as! String),
                    imageURL: URL(string: (document.data()["imageURLString"] as! String)),
                    ingredients: (document.data()["ingredients"] as? [String] ?? []),
                    steps: (document.data()["steps"] as? [String] ?? []),
                    contributor: (document.data()["contributor"] as! String),
                    publisher: (document.data()["publisher"] as! String)
                ))
            }
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
