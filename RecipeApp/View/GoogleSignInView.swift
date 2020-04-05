//
//  GoogleSignInView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 4/4/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import GoogleSignIn

struct GoogleSignInView : UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<GoogleSignInView>) -> GIDSignInButton {
        let button = GIDSignInButton()
        //button.colorScheme = .dark
        //button.style = .iconOnly
        button.isHidden = true
        
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        return button
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<GoogleSignInView>) {
    }
    
    func signIn() {
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        GIDSignIn.sharedInstance()?.signIn()
    }
    
}
