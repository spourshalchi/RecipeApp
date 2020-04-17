//
//  ListTest.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 4/17/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI

struct ListTest: View {
    @State var array : [TextStruct] = [TextStruct(text:"Row 1"), TextStruct(text:"Row 2"), TextStruct(text:"Row 3")]
    @State var flag : Bool = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        NavigationView{
            VStack{
                List {
                    Section(header: Text("Examples")
                        .offset(x: self.dragAmount.width)
                        .onTapGesture {
                        self.flag.toggle()
                        }
                        .gesture(
                            DragGesture()
                                .onChanged { self.dragAmount = $0.translation }
                                .onEnded { _ in
                                    self.dragAmount = .zero
                                }
                        )) {
                            
                        ForEach(array) { item in
                            Text(item.text)
                        }.onDelete(perform: deleteItems)
                    }
                }
//                .listStyle(GroupedListStyle())
//                .environment(\.horizontalSizeClass, .regular)
                
                Image(systemName: flag ? "book.fill": "book")
            }
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        array.remove(atOffsets: offsets)
    }
}

struct ListTest_Previews: PreviewProvider {
    static var previews: some View {
        ListTest()
    }
}

struct TextStruct: Identifiable {
    let id = UUID()
    var text : String
}


