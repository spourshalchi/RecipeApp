//
//  EmailSignUpView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 4/5/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI

struct EmailSignUpView: View {
    @State var email = ""
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
                        .frame(width: buttonWidth*0.33, height: 10)
                }
            }
            
            //Button
            NavigationLink(destination: EmailSignUpView2(email: self.$email)) {
                Text("Next")
                    .fontWeight(.bold)
                    .padding(10)
                    .frame(width: buttonWidth)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }.padding()
    }
}

struct EmailSignUpView2: View {
    @Binding var email: String
    @State private var password = ""
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
                        .frame(width: buttonWidth*0.66, height: 10)
                }
            }
            
            //Button
            NavigationLink(destination: EmailSignUpView3(email: self.$email, password: self.$password)) {
                Text("Next")
                    .fontWeight(.bold)
                    .padding(10)
                    .frame(width: buttonWidth)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }.padding()
    }
}

struct EmailSignUpView3: View {
    //Login Variables
    @EnvironmentObject var userSession: SessionStore
    @Binding var email: String
    @Binding var password: String
    @State private var name = ""
    
    //Misc
    let buttonWidth = UIScreen.main.bounds.size.width * 0.8

    //Error Variables
    @State var msg = ""
    @State var alert = false
    
    func signUp() {
        userSession.signUp(email: email, password: password) { (result, error) in
            if let error = error {
                self.msg = error.localizedDescription
                self.alert.toggle()
            } else {
                UserDefaults.standard.set(true, forKey: "status")
            }
        }
    }
    
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
                        .frame(width: buttonWidth*1.0, height: 10)
                }
            }
            
            //Button
            Button(action: signUp) {
                Text("Sign Up")
                    .fontWeight(.bold)
                    .padding(10)
                    .frame(width: buttonWidth)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }.padding()
        .alert(isPresented: $alert) {
            Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
        }
    }
}

struct EmailSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        EmailSignUpView()
    }
}

struct EmailSignUpView2_Previews: PreviewProvider {
    static var previews: some View {
        EmailSignUpView2(email: .constant("test@email.com"))
    }
}

struct EmailSignUpView3_Previews: PreviewProvider {
    static var previews: some View {
        EmailSignUpView3(email: .constant("test@email.com"), password: .constant("password"))
    }
}

 
