//
//  CardFromURLViewModel.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/21/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import SwiftSoup

class RecipeViewModel: ObservableObject {
    @Published var recipe = Recipe(recipeURLString:"" , imageURLString:"",title:"", imageURL:nil,ingredients:[],steps:[], contributor: "", publisher: "")
    
    func setRecipe(recipeURLString: String) {
        let url = URL(string: recipeURLString)

        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print("error")
            }
                
            else{
                let htmlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                //print(htmlContent!)
                do {
                    let doc: Document = try SwiftSoup.parse(htmlContent! as String)
                    
                    //Get recipe imageURL
                    let srcs: Elements = try doc.select("img[srcset]")
                    let srcsStringArray: [String?] = srcs.array().map { try? $0.attr("srcset").description }
                    let str = String(srcsStringArray[0] ?? "")
                    
                    //Get recipe title
                    let links: Elements = try doc.getElementsByClass("top-anchor")
                    var title = ""
                    do {
                         title = try links[0].html()
                    } catch Exception.Error(_, let message) {
                        print(message)
                    }
                    
                    //Get recipe ingredients
                    let ingredients: Elements = try doc.getElementsByClass("ingredient")
                    let ingredientsStringArray: [String?] = ingredients.array().map { try? $0.child(0).text()}
                    
                    //Get recipe steps
                    let steps: Elements = try doc.getElementsByClass("step")
                    let stepsStringArray: [String?] = steps.array().map { try? $0.child(0).text()}
                   
                    
                    //Set recipe data
                    if let range = str.range(of: ".jpg") {
                        let link = String(str[..<range.upperBound])
                        DispatchQueue.main.async {
                            self.recipe.imageURLString = link
                            self.recipe.imageURL = URL(string: link)!
                            self.recipe.title = title
                            self.recipe.steps = stepsStringArray as! [String]
                            self.recipe.ingredients = ingredientsStringArray as! [String]
                        }
                    }

                } catch Exception.Error(_, let message) {
                    print(message)
                } catch {
                    print("error")
                }
            }
        }
        task.resume()
    }
}
