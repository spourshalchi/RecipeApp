//
//  RecipeView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/21/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct RecipeView: View {
    //Recipe view model
    @EnvironmentObject var recipeBook: RecipeBookViewModel
    @EnvironmentObject var shoppingList: ShoppingListViewModel
    let textWidth = UIScreen.main.bounds.size.width * 0.95
    @State var showRatingModal: Bool = false
    
    let recipe: Recipe
    var onDismiss: () -> ()
    
    var body: some View {
        ScrollView{
            VStack{
                ZStack(alignment: .bottomTrailing){
                    //Image
                    KFImage(self.recipe.imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.size.width)
                    
                    //Bookmark
                    Button(action: {
                        //Add only if not already in
                        if let index = self.recipeBook.recipes.firstIndex(of: self.recipe) {
                            self.recipeBook.recipes.remove(at: index)
                        } else {
                            //Add recipe to recipe book
                            self.recipeBook.recipes.append(self.recipe)
                        }
                        //THIS CODE IS NEEDED BECAUSE OF A BUG IN SWIFT 5.2 AND SHOULD BE RESOLVED IN THE NEXT VERSION https://bugs.swift.org/browse/SR-12089
                        var newRecipes = [Recipe]() //new temporary array
                        for recipeInBook in self.recipeBook.recipes {
                            newRecipes.append(recipeInBook) //copy class array to temp array
                        }
                        self.recipeBook.recipes = newRecipes
                    }) {
                        HStack{
                            Image(systemName: self.recipeBook.recipes.contains(recipe) ? "book.fill": "book")
                            Text(self.recipeBook.recipes.contains(recipe) ? "Unsave" : "Save").fontWeight(.bold)
                        }
                        .padding(10)
                        .background(Color.black.opacity(0.5))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .padding(7)
                    }
                }
                
                //Title
                Text(self.recipe.title)
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .frame(width: textWidth, alignment: .leading)
                
                //Contributor
                Text(self.recipe.contributor.uppercased())
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(width: textWidth, alignment: .leading)
                    .padding(.bottom, 10)
                
                //Yield
                if (self.recipe.yield != "")  {
                    Text(self.recipe.yield)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .frame(width: textWidth, alignment: .leading)
                }
                
                //Time
                if (self.recipe.timeToMake != "") {
                    Text(self.recipe.timeToMake)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .frame(width: textWidth, alignment: .leading)
                        .padding(.bottom, 12)
                }
                
                //Cooked and review spacer
                ZStack{
                    Rectangle()
                        .fill(Color("BackgroundNeu"))
                        .frame(width: UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.width*0.1)
                    HStack{
                        HStack{
                            Text("COOKED?")
                                .foregroundColor(.gray)
                                .font(.footnote)
                                .fontWeight(.bold)
                            Image(systemName: "checkmark.circle").foregroundColor(.gray)
                        }.padding()
                        .onTapGesture {
                            self.showRatingModal = true
                        }.sheet(isPresented: self.$showRatingModal) {
                            RatingView(recipe:self.recipe, onDismiss: {self.showRatingModal = false}).environmentObject(self.recipeBook).environmentObject(self.shoppingList)
                        }

                        Spacer()
                        
                        if(self.recipe.numRatings != 0) {
                            HStack{
                                Text("\(self.recipe.numRatings)")
                                    .foregroundColor(Color("Black"))
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                StarRating(rating: self.recipe.avgRating)
                            }.padding()
                        } else {
                            Text("No ratings yet")
                                .foregroundColor(.gray)
                                .font(.footnote)
                                .fontWeight(.bold)
                                .padding()
                        }
                    }
                }

                //Ingredients header
                Text("Ingredients".uppercased())
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(width: textWidth, alignment: .leading)
                    .padding(.bottom, 20)
                
                //Ingredients
                VStack(spacing: 15){
                    ForEach(self.recipe.ingredients, id: \.self) { ingredient in
                        Text(ingredient)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: self.textWidth, alignment: .leading)
                    }
                    
                    //Add recipe ingredients to grocery list
                    Button(action:{
                        
                        //Add only if not already in
                        if self.shoppingList.shoppingList.firstIndex(of: ShoppingListItem(recipe: self.recipe)) == nil {
                            //Add to shopping list
                            self.shoppingList.shoppingList.append(ShoppingListItem(recipe: self.recipe))
                        }
                    }) {
                        Text("Add to Your Shopping List")
                            .fontWeight(.bold)
                            .padding(10)
                            .frame(width: textWidth)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    
                    Divider()
                }.padding(.bottom, 20)
                
                //Steps header
                Text("Steps".uppercased())
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(width: textWidth, alignment: .leading)
                    .padding(.bottom, 20)
                
                //Steps
                VStack(spacing: 15){
                    ForEach(self.recipe.steps, id: \.self) { step in
                        VStack(){
                            Text("Step")
                                .font(.footnote)
                                .fontWeight(.bold)
                                .frame(width: self.textWidth, alignment: .leading)
                            Text(step)
                                .font(.footnote)
                                .frame(width: self.textWidth, alignment: .leading)
                        }
                    }
                }
            }
        }
    }
}

struct StarRating : View {
    @State var rating : Float
    
    var body : some View {
        HStack{
            ForEach(1 ... Int(floor(self.rating)), id: \.self) { number in
                Image(systemName: "star.fill").foregroundColor(Color("Gold"))
            }
            //0.5
            if(rating-floor(self.rating) > 0.25 && rating-floor(self.rating) < 0.75) {
                Image(systemName: "star.lefthalf.fill").foregroundColor(Color("Gold"))
            }
            //Round up
            else if(rating-floor(self.rating) >= 0.75 ) {
                Image(systemName: "star.fill").foregroundColor(Color("Gold"))
            }
        }
    }
}

struct StarRating_Previews: PreviewProvider {
    static var previews: some View {
        StarRating(rating: 3.3)
    }
}

struct RatingView : View {
    var recipe : Recipe
    var onDismiss: () -> ()
    let textWidth = UIScreen.main.bounds.size.width * 0.95
    @State var reviewText: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body : some View {
        VStack(alignment: .leading){
            //Title
            HStack(alignment:.top){
                Text(self.recipe.title)
                Spacer()
                Button(action: {self.presentationMode.wrappedValue.dismiss()}){
                    Image(systemName: "xmark")
                }
            }
            
            //Star rating
            StarRating(rating: 3.3)
            
            //Text area
            TextField("It was SO delicious! Cook for 5 minutes longer to make it extra crispy!", text: $reviewText)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(nil)
                
            Spacer()
        }
        .frame(width: self.textWidth, alignment: .leading)
        .padding()
    }
}

struct TextView: UIViewRepresentable {
    @Binding var text: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {

        let myTextView = UITextView()
        myTextView.delegate = context.coordinator

        myTextView.font = UIFont(name: "HelveticaNeue", size: 15)
        myTextView.isScrollEnabled = true
        myTextView.isEditable = true
        myTextView.isUserInteractionEnabled = true
        myTextView.backgroundColor = UIColor(white: 0.0, alpha: 0.05)

        return myTextView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    class Coordinator : NSObject, UITextViewDelegate {

        var parent: TextView

        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            print("text now: \(String(describing: textView.text!))")
            self.parent.text = textView.text
        }
    }
}
