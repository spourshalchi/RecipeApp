//
//  TestView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/22/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct TestView: View {
    let link = "https://assets.bonappetit.com/photos/5e6ac0e70847910008100987/3:2/w_5120,c_limit/BBaking_WEEK6_Biscuts_2.jpg"
    @State var modalDisplayed = false
    let recipe = Recipe(uid: 0, recipeURLString:"https://www.bonappetit.com/recipe/sour-cream-and-onion-biscuits" , imageURLString:"https://assets.bonappetit.com/photos/5e6ac0e70847910008100987/3:2/w_5120,c_limit/BBaking_WEEK6_Biscuts_2.jpg",title:"Sour Cream and Onion Biscuits", imageURL:URL(string: "https://assets.bonappetit.com/photos/5e6ac0e70847910008100987/3:2/w_5120,c_limit/BBaking_WEEK6_Biscuts_2.jpg")!)

    var body: some View {
        VStack{
            KFImage(URL( string: link)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 300)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .animation(Animation.spring())
                .onTapGesture {
                    self.modalDisplayed = true
                }.sheet(isPresented: $modalDisplayed) {
                    RecipeView(recipe:self.recipe, onDismiss: {self.modalDisplayed = false})
                }
        }
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

struct DetailView: View {
    var onDismiss: () -> ()
    
    var body: some View {
        Text("Woot")
    }
}
