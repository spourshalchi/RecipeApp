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
                    }
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
                                    ingredientRow(ingredient: ing, index: item.recipe.ingredients.firstIndex(of: ing)!, parentRecipe:item)
                                }//.onDelete { self.delete(at: $0, in: self.shoppingList.shoppingList.firstIndex(of: item)!) }
                            }
                        }
                    }//.onDelete(perform: deleteRec)
                }
        }
    }
    
    var disableDelete: Bool {
        if let mode = editMode?.wrappedValue, mode == .active {
            return true
        }
        return false
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
                        ingredientRow(ingredient: ing, index: self.shoppingList.shoppingList.firstIndex(of: item)!, parentRecipe:item)
                    }//.onDelete { self.delete(at: $0, in: self.shoppingList.shoppingList.firstIndex(of: item)!) }
                }
            }
        }
    }
    
    var disableDelete: Bool {
        if let mode = editMode?.wrappedValue, mode == .active {
            return true
        }
        return false
    }
}

struct ingredientRow : View {
    @State var ingredient : String
    @State private var dragAmount = CGSize.zero
    @State var draggedToMax: Bool = false
    @State var draggedToMin: Bool = false
    @State var striked: Bool = false
    @State var index: Int
    @EnvironmentObject var shoppingList: ShoppingListViewModel
    @State var parentRecipe: ShoppingListItem
    
    var body: some View {
        HStack{
            Text(ingredient)
                .strikethrough(self.striked)
                .padding()
                .offset(x: self.dragAmount.width)
                .contentShape(Rectangle())
        }

        .gesture(
            DragGesture()
                .onChanged {
                    if ($0.translation.width < 20 && $0.translation.width > -60) {
                        self.dragAmount = $0.translation
                        self.draggedToMax = false
                    }
                        
                    //Delete
                    else if ($0.translation.width < -60 && !self.draggedToMin) {
                        self.simpleSuccess()
                        self.draggedToMin = true
                    }
                        
                    //Strike
                    else if ($0.translation.width < 80 && $0.translation.width > -60) {
                        self.dragAmount = $0.translation
                    }
                    else if ($0.translation.width > 80 && !self.draggedToMax) {
                        self.simpleSuccess()
                        self.draggedToMax = true
                    }
                }
                .onEnded { _ in
                    if(self.draggedToMax){ self.striked.toggle() }
                    if(self.draggedToMin){ self.delete(recipe:self.parentRecipe, index: self.index)}
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
    
    func delete(recipe: ShoppingListItem, index: Int) {
        print(index)
        self.shoppingList.shoppingList[self.shoppingList.shoppingList.firstIndex(of: recipe)!].recipe.ingredients.remove(at: index)
    }
}
