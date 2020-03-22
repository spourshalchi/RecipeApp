//
//  CardFromURLViewModel.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/21/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import SwiftSoup

class CardFromURLViewModel: ObservableObject {
    @Published var imageURL: URL!
    
    func getImageURL(recipeURLString: String) {
        let url = URL(string: recipeURLString)

        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print("error")
            }
            else{
                let htmlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)

                do {
                    let doc: Document = try SwiftSoup.parse(htmlContent! as String)
                    let srcs: Elements = try doc.select("img[srcset]")
                    let srcsStringArray: [String?] = srcs.array().map { try? $0.attr("srcset").description }
                    
                    let str = String(srcsStringArray[0] ?? "")
                    if let range = str.range(of: ".jpg") {
                        let link = String(str[..<range.upperBound])
                        DispatchQueue.main.async {
                            self.imageURL = URL(string: link)!
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
