//
//  LoginView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 4/4/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginView: View {
        
    let buttonWidth = UIScreen.main.bounds.size.width * 0.8
    let google = GoogleSignInView()
    @Binding var showModal: Bool
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 10){
            
            //X, log in row
            ZStack{
                HStack {
                    Button(action: {
                        self.showModal.toggle()
                    }) {
                        Image(systemName:"xmark").padding(10)
                    }
                    Spacer()
                }
                
                Text("Log in")
            }
            
            //Login in with Facebook
            Button(action: {
                
            }) {
                Text("Log in with Facebook")
                .fontWeight(.bold)
                .padding(10)
                .frame(width: buttonWidth)
                .background(Color("Facebook"))
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            
            //Login with Google
            Button(action: {
                GoogleSignInView().signIn()
            }) {
                Text("Log in with Google")
                .fontWeight(.bold)
                .padding(10)
                .frame(width: buttonWidth)
                .background(Color("Google"))
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            
            
            //Log in with Apple
            Button(action: {
                
            }) {
                Text("Log in with Apple")
                .fontWeight(.bold)
                .padding(10)
                .frame(width: buttonWidth)
                .background(Color.black)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            
            Text("OR")
            
            Group{
                //Email
                VStack(alignment: .leading){
                    Text("Email")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label).opacity(0.75))
                    
                    HStack{
                        TextField("Enter Your Email", text: $email)
                        if email != ""{
                            Image(systemName:"checkmark")
                                .foregroundColor(Color.init(.label))
                        }
                    }
                    Divider()
                }
                
                //Password
                VStack(alignment: .leading){
                    Text("Password")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label).opacity(0.75))
                        
                    SecureField("Enter Your Password", text: $password)

                    Divider()
                }
            }.padding()
            
            //Log in with Apple
            Button(action: {
                //Log in action
            }) {
                Text("Log in")
                .fontWeight(.bold)
                .padding(10)
                .frame(width: buttonWidth)
                .background(Color.gray)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            
            //Agree text
            Text("By continuing, you agree to Recip.io's Terms of Service and Privacy Policy")
                .font(.footnote)
                .frame(maxWidth:buttonWidth)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            //Forgot password?
            Button(action: {
                
            }) {
                Text("Forgot password?")
                .foregroundColor(.black)
            }.padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(showModal: .constant(true))
    }
}
