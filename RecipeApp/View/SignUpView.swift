//
//  SignUpView.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 4/4/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var msg = ""
    @State var alert = false
    @EnvironmentObject var session: SessionStore
    
    func signUp() {
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error {
                self.msg = error.localizedDescription
                self.alert.toggle()
            } else {
                UserDefaults.standard.set(true, forKey: "status")
            }
        }
    }
    
    var body: some View {
        VStack{
            Image(systemName:"flame")
            
            Text("Sign Up")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.top,.bottom], 20)
            
            VStack(alignment: .leading){
                //Username
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
                }.padding(.bottom, 15)
                
                //Password
                VStack(alignment: .leading){
                    Text("Password")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label).opacity(0.75))
                    
                    SecureField("Enter Your Password", text: $password)
                    Divider()
                }
            }.padding(.horizontal, 6)
            
            Button(action: signUp) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 120)
                    .padding()
            }.background(Color.black)
                .clipShape(Capsule())
                .padding(.top, 45)
            
            }.padding()
        .alert(isPresented: $alert) {
            Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SessionStore())
    }
}
