//
//  CardFromURL.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/15/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import SwiftSoup
import struct Kingfisher.KFImage

struct CardFromURL: View {
    @ObservedObject var cardFromURLViewModel = CardFromURLViewModel()
    
    init(recipeURLString: String){
        self.cardFromURLViewModel.getImageURL(recipeURLString: recipeURLString)
    }

    var body: some View {
        VStack(alignment: .trailing){
            KFImage(cardFromURLViewModel.imageURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 300)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            //...
//            Image(systemName: "ellipsis")
//                .font(.system(size: 12))
//                .padding(.horizontal,5)
        }
    }
}

struct CardFromURL_Previews: PreviewProvider {
    static var previews: some View {
        CardFromURL(recipeURLString: "https://www.bonappetit.com/recipe/sour-cream-and-onion-biscuits")
    }
}
