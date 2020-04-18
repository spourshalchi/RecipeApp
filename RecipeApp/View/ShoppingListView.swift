//
//  ShoppingListView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 4/17/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ShoppingListView: View {
    @EnvironmentObject var shoppingList: ShoppingListViewModel
    
    init() {
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().separatorStyle = .none
      }
    
    var body: some View {
            NavigationView {
                VStack {
                    List {
                        ForEach(shoppingList.shoppingList) { item in
                            Group{
                                HStack(){
                                    //Image
                                    KFImage(item.recipe.imageURL)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 40)
                                        .clipped()
                                    
                                    //Text
                                    Text(item.recipe.title)
                                    Spacer()
                                }.padding(.leading,5)
                                .onTapGesture {
                                    self.shoppingList.shoppingList[self.shoppingList.shoppingList.firstIndex(of: item)!].show.toggle()
                                }
                                
                                if(item.show) {
                                    ForEach(item.recipe.ingredients,  id: \.self){ ing in
                                        Text(ing)
                                    }.onDelete { self.delete(at: $0, in: self.shoppingList.shoppingList.firstIndex(of: item)!) }
                                }
                            }
                        }.onDelete(perform: deleteRec)
                    }
            }
                .navigationBarTitle(Text("Shopping List"), displayMode: .inline)
                .navigationBarItems(trailing: EditButton())
            }
    }
    
    
    func deleteRec(at offsets: IndexSet) {
        self.shoppingList.shoppingList.remove(atOffsets: offsets)
    }
    
    func delete(at offsets: IndexSet, in shopItem: Int) {
        self.shoppingList.shoppingList[shopItem].recipe.ingredients.remove(atOffsets: offsets)
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}
