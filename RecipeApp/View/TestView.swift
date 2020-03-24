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
    let links: [String] = ["https://www.bonappetit.com/recipe/green-garlic-roast-chicken", "https://www.bonappetit.com/recipe/fusilli-with-battuto-di-erbe", "https://www.bonappetit.com/recipe/sour-cream-and-onion-biscuits", "https://www.bonappetit.com/recipe/rigatoni-with-fennel-and-anchovies","https://www.bonappetit.com/recipe/pork-and-asparagus-stir-fry", "https://www.bonappetit.com/recipe/ramen-noodles-with-spring-onions"]
        //let links: [String] = ["https://www.bonappetit.com/recipe/green-garlic-roast-chicken", "https://www.bonappetit.com/recipe/fusilli-with-battuto-di-erbe"]

    var body: some View {
        ScrollView{
            VStack(){
                ForEach(0 ..< links.count) {
                    CardFromURL(recipeURLString: self.links[$0])
                }
            }
        }
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

