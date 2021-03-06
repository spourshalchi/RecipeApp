//
//  WelcomeView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 4/4/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    @State var signUpClicked = false
    
    var body: some View {
        NavigationView{
            ZStack{
                //Image
                VStack{
                    Image("Eggs")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: UIScreen.main.bounds.size.height * 0.6)
                        
                    Spacer()
                }
                
                //Cover
                VStack{
                    Spacer()
                    Rectangle()
                        .foregroundColor(Color("White"))
                        .frame(height: signUpClicked ? UIScreen.main.bounds.size.height * 0.6 : UIScreen.main.bounds.size.height * 0.4)
                    }
                
                //Gradient
                VStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: signUpClicked ? UIScreen.main.bounds.size.height * 0.4 : UIScreen.main.bounds.size.height * 0.6)
                        .background(LinearGradient(gradient: Gradient(colors: [.clear, .clear, Color("White")]), startPoint: .top, endPoint: .bottom))
                    Spacer()
                    }
                
                if(signUpClicked) {
                    SignUpContent(signUpClicked: self.$signUpClicked)
                } else {
                    WelcomeContent(signUpClicked: self.$signUpClicked)
                }
            }.edgesIgnoringSafeArea(.all)
        }.navigationBarHidden(true)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}


struct WelcomeContent: View {
    @Binding var signUpClicked: Bool
    let buttonWidth = UIScreen.main.bounds.size.width * 0.8
    @State private var showModal = false
    
    var body: some View {
        VStack{
            //Spacer
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: UIScreen.main.bounds.size.height * 0.6)
            
            //Logo
            Image("R")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:120)
                .padding()
            
//            Text("Welcome to Recipeasy")
//                .font(.system(.headline, design: .serif))
//                .frame(width: UIScreen.main.bounds.size.height)
//                .padding(.bottom, 20)
            
            //Sign Up
            Button(action: {
                withAnimation(.easeIn(duration: 0.1)){
                    self.signUpClicked = true
                }
            }) {
                Text("Sign up")
                .fontWeight(.bold)
                .padding(10)
                .frame(width: buttonWidth)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }

            //Login
            NavigationLink(destination: LoginView(showModal: self.$showModal)) {
                Text("Log in")
                    .fontWeight(.medium)
                    .padding()
                    .foregroundColor(Color("Black"))
            }
        }
    }
}

struct SignUpContent: View {
    @Binding var signUpClicked: Bool
    let buttonWidth = UIScreen.main.bounds.size.width * 0.8
    @State private var showModal = false
    @EnvironmentObject var userSession: SessionStore

    
    var body: some View {
        VStack(spacing: 10){
            //Spacer
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: UIScreen.main.bounds.size.height * 0.4)
            
             //Logo
            Image("R")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:120)

            //Text
            Text("Choose a signup method")
                .fixedSize(horizontal: true, vertical: false)
                .padding()

            //Sign Up
            NavigationLink(destination: EmailSignUpView()) {
                Text("Continue with email")
                    .fontWeight(.bold)
                    .padding(10)
                    .frame(width: buttonWidth)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            
            //Continue with Facebook
            Button(action: {
                
            }) {
                Text("Continue with Facebook")
                .fontWeight(.bold)
                .padding(10)
                .frame(width: buttonWidth)
                .background(Color("Facebook"))
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            
            //Continue with Google
            Button(action: {
                GoogleSignInView().signIn()
            }) {
                Text("Continue with Google")
                .fontWeight(.bold)
                .padding(10)
                .frame(width: buttonWidth)
                .background(Color("Google"))
                .foregroundColor(.white)
                .clipShape(Capsule())
            }

            //Already have an account? Log in
            NavigationLink(destination: LoginView(showModal: self.$showModal)) {
                Text("Already have an account? Log in")
                    .fontWeight(.medium)
                    .foregroundColor(Color("Black"))
                    .padding()
            }
            
            //Agree text
            Text("By continuing, you agree to Recipeasy's Terms of Service and Privacy Policy")
                .font(.footnote)
                .frame(maxWidth:buttonWidth)
                .multilineTextAlignment(.center)
        }
    }
}
