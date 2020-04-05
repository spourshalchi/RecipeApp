//
//  EmailSignUpView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 4/5/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI

struct EmailSignUpView: View {
    @State private var email = ""
    @State var currentProgress: CGFloat = 0.33
    let buttonWidth = UIScreen.main.bounds.size.width * 0.8
    
    var body: some View {
        VStack(spacing: 40) {
            //Email text
            VStack(alignment: .leading) {
                Text("What's your email?")
                    .font(.title)
                    .bold()
                TextField("Email address", text: $email)
            }
                
            VStack(alignment: .trailing) {
                //Step
                Text("1 of 3")
                    .fontWeight(.bold)
                    .font(.footnote)
                
                //Progress bar
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.init(UIColor.lightGray))
                        .frame(width: buttonWidth, height: 10)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.black)
                        .frame(width: buttonWidth*currentProgress, height: 10)
                }
            }
            
            //Button
            NavigationLink(destination: EmailSignUpView2()) {
                Text("Next")
                    .fontWeight(.bold)
                    .padding(10)
                    .frame(width: buttonWidth)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }.padding().KeyboardAwarePadding()
    }
}




struct EmailSignUpView2: View {
    @State private var password = ""
    @State var currentProgress: CGFloat = 0.66
    let buttonWidth = UIScreen.main.bounds.size.width * 0.8

    var body: some View {
        VStack(spacing: 40) {
            //Password text
            VStack(alignment: .leading) {
                Text("Create a password")
                    .font(.title)
                    .bold()
                SecureField("Password", text: $password)
            }
            
            VStack(alignment: .trailing) {
                //Step
                Text("2 of 3")
                    .fontWeight(.bold)
                    .font(.footnote)
                
                //Progress bar
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.init(UIColor.lightGray))
                        .frame(width: buttonWidth, height: 10)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.black)
                        .frame(width: buttonWidth*currentProgress, height: 10)
                }
            }
            
            //Button
            NavigationLink(destination: EmailSignUpView3()) {
                Text("Next")
                    .fontWeight(.bold)
                    .padding(10)
                    .frame(width: buttonWidth)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }.padding().KeyboardAwarePadding()
    }
}


struct EmailSignUpView3: View {
    @State private var name = ""
    @State var currentProgress: CGFloat = 1.0
    let buttonWidth = UIScreen.main.bounds.size.width * 0.8
    
    var body: some View {
        VStack(spacing: 40) {
            //Name text
            VStack(alignment: .leading) {
                Text("What's your name?")
                    .font(.title)
                    .bold()
                TextField("Name", text: $name)
            }
            
            VStack(alignment: .trailing) {
                //Step
                Text("3 of 3")
                    .fontWeight(.bold)
                    .font(.footnote)
                
                //Progress bar
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.init(UIColor.lightGray))
                        .frame(width: buttonWidth, height: 10)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.black)
                        .frame(width: buttonWidth*currentProgress, height: 10)
                }
            }
            
            //Button
            NavigationLink(destination: Text("")) {
                Text("Next")
                    .fontWeight(.bold)
                    .padding(10)
                    .frame(width: buttonWidth)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }.padding().KeyboardAwarePadding()
    }
}


struct EmailSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        EmailSignUpView()
    }
}

struct EmailSignUpView2_Previews: PreviewProvider {
    static var previews: some View {
        EmailSignUpView2()
    }
}

struct EmailSignUpView3_Previews: PreviewProvider {
    static var previews: some View {
        EmailSignUpView3()
    }
}



//Keyboard padding
import Combine

struct KeyboardAwareModifier: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    private var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
                .map { $0.cgRectValue.height },
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in CGFloat(0) }
       ).eraseToAnyPublisher()
    }

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(keyboardHeightPublisher) { self.keyboardHeight = $0 }
    }
}

extension View {
    func KeyboardAwarePadding() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAwareModifier())
    }
}
