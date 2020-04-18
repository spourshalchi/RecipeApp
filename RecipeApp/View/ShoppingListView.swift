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
    @State var sortExpand: Bool = false
    @State var sortMethod: String = "Recipe"
    
    init() {
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().separatorStyle = .none
      }
    
    var body: some View {
            VStack{
                HStack{
                    //Sort
                    HStack{
                        Image(systemName: "chevron.down")
                        Text("Sort")
                    }
                    .foregroundColor(Color.red)
                    .padding()
                    .onTapGesture {
                        self.sortExpand.toggle()
                    }
                    .actionSheet(isPresented: self.$sortExpand) {
                        ActionSheet(title: Text("Sort Method"), buttons: [
                            .default(Text("Recipe")) { self.sortMethod = "Recipe" },
                            .default(Text("Alphabetical")) { self.sortMethod = "Alpha" },
                            .default(Text("Food Group")) { self.sortMethod = "FoodGroup" },
                            .cancel()
                        ])
                    }
                    
                    Spacer()
                    
                    //Share
                    Button(action: {

                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }.padding()
                }
                
                if(self.sortMethod == "Recipe"){
                    SortedByRecipe()
                }
                else if (self.sortMethod == "Alpha"){
                    SortedByAlphabetical()
                } else {
                    SortedByRecipe()
                }
            }
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}

struct SortedByRecipe : View {
    @EnvironmentObject var shoppingList: ShoppingListViewModel
    @Environment(\.editMode) var editMode
    
    var body: some View {
            VStack {
                List {
                    ForEach(shoppingList.shoppingList) { item in
                        Group{
                            HStack(){
                                //Image
                                KFImage(item.recipe.imageURL)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipped()
                                
                                //Text
                                VStack(alignment: .leading){
                                    Text(item.recipe.title)
                                    Text(item.recipe.publisher).font(.footnote)
                                }
                                Spacer()
                            }.padding(.leading,5)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                self.shoppingList.shoppingList[self.shoppingList.shoppingList.firstIndex(of: item)!].show.toggle()
                            }
                            .listRowBackground(Color.gray)
                            
                            if(item.show) {
                                ForEach(item.recipe.ingredients,  id: \.self){ ing in
                                    ingredientRow(ingredient: ing, parentRecipe:item)
                                }
                            }
                        }
                    }.onDelete(perform: deleteRec)
                }
        }
    }
    
    func deleteRec(at offsets: IndexSet) {
        self.shoppingList.shoppingList.remove(atOffsets: offsets)
    }
}

struct SortedByAlphabetical : View {
    @EnvironmentObject var shoppingList: ShoppingListViewModel
    @Environment(\.editMode) var editMode
    
    var body: some View {
        VStack {
            List {
                ForEach(shoppingList.shoppingList) { item in
                    ForEach(item.recipe.ingredients,  id: \.self){ ing in
                        ingredientRow(ingredient: ing, parentRecipe:item)
                    }
                }
            }
        }
    }
}

struct ingredientRow : View {
    @State var ingredient : String
    @State private var dragAmount = CGSize.zero
    @State var draggedToMax: Bool = false
    @State var draggedToMin: Bool = false
    @State var striked: Bool = false
    @EnvironmentObject var shoppingList: ShoppingListViewModel
    @State var parentRecipe: ShoppingListItem
    
    var body: some View {
        HStack(){
            //Image(systemName: "checkmark")
            HStack{
                Text(ingredient)
                    .strikethrough(self.striked)
                    .multilineTextAlignment(.leading)
                    .frame(alignment: .leading)
                    .padding()
                    .contentShape(Rectangle())
            }.frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
            Image(systemName: "xmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.red)
                .frame(width:30)
        }.offset(x: self.dragAmount.width)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .contentShape(Rectangle())
        .gesture(
            DragGesture(minimumDistance: 20)
                .onChanged {
                    if ($0.translation.width < 60 && $0.translation.width > -100) {
                        self.dragAmount = $0.translation
                        self.draggedToMax = false
                        self.draggedToMin = false
                    }
                        
                    //Delete
                    else if ($0.translation.width < -100 && !self.draggedToMin) {
                        self.simpleSuccess()
                        self.draggedToMin = true
                    }
                        
                    //Check off
                    else if ($0.translation.width < 60 && $0.translation.width > -100) {
                        self.dragAmount = $0.translation
                    }
                    else if ($0.translation.width > 60 && !self.draggedToMax) {
                        self.simpleSuccess()
                        self.draggedToMax = true
                        self.striked.toggle()
                    }
                }
                .onEnded { _ in
                    if(self.draggedToMin){ self.delete(recipe:self.parentRecipe, ingredient: self.ingredient)}
                    self.dragAmount = .zero
                    self.draggedToMax = false
                    self.draggedToMin = false
                }
            )
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    
    func delete(recipe: ShoppingListItem, ingredient: String) {
        let recIndex = self.shoppingList.shoppingList.firstIndex(of: recipe)!
        let ingIndex = self.shoppingList.shoppingList[recIndex].recipe.ingredients.firstIndex(of: ingredient)!
        self.shoppingList.shoppingList[recIndex].recipe.ingredients.remove(at: ingIndex)
    }
}
