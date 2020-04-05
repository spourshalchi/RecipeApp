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
                        .foregroundColor(.white)
                        .frame(height: signUpClicked ? UIScreen.main.bounds.size.height * 0.6 : UIScreen.main.bounds.size.height * 0.4)
                    }
                
                //Gradient
                VStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: signUpClicked ? UIScreen.main.bounds.size.height * 0.4 : UIScreen.main.bounds.size.height * 0.6)
                        .background(LinearGradient(gradient: Gradient(colors: [.clear, .clear, .white]), startPoint: .top, endPoint: .bottom))
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
            Image(systemName: "flame")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:80)
                .foregroundColor(.red)

            //Text
            Text("Welcome")
                .font(.title)
                .fontWeight(.medium)
                .padding()

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
            Button(action: {
                self.showModal.toggle()
            }) {
                Text("Log in")
                .fontWeight(.medium)
                .foregroundColor(.black)
            }.padding()
            .sheet(isPresented: $showModal) {
                LoginView(showModal: self.$showModal)
            }
        }
    }
}

struct SignUpContent: View {
    @Binding var signUpClicked: Bool
    let buttonWidth = UIScreen.main.bounds.size.width * 0.8
    @State private var showModal = false
    
    var body: some View {
        VStack(spacing: 10){
            //Spacer
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: UIScreen.main.bounds.size.height * 0.4)
            
            //Logo
            Image(systemName: "flame")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:80)
                .foregroundColor(.red)

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
            Button(action: {
                self.showModal.toggle()
            }) {
                Text("Already have an account? Log in")
                .fontWeight(.medium)
                .foregroundColor(.black)
            }.padding()
            .sheet(isPresented: $showModal) {
                LoginView(showModal: self.$showModal)
            }
            
            //Agree text
            Text("By continuing, you agree to Recip.io's Terms of Service and Privacy Policy")
                .font(.footnote)
                .frame(maxWidth:buttonWidth)
                .multilineTextAlignment(.center)
        }
    }
}
