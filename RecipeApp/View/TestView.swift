//
//  TestView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/22/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        Image("meal")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width:20)
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

