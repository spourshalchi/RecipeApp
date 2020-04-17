//
//  SessionStore.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/29/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import SwiftUI
import Firebase
import Combine
import GoogleSignIn
import FirebaseFirestore

class SessionStore: ObservableObject {
    @Published var currentUser: User?
    @Published var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                let db = Firestore.firestore()
                let docRef = db.collection("users").document(user.uid)
                
                docRef.getDocument { (document, error) in
                    //If user is already in the db, populate the userSession with profile info
                    if let document = document, document.exists {
                        self.currentUser = User(
                            uid: user.uid,
                            displayName:user.displayName,
                            email: user.email,
                            photoURL: (document.get("photoURL") as? String ?? ""),
                            followers: (document.get("followers") as? [String] ?? []),
                            following: document.get("following") as? [String] ?? [],
                            recipeBook: document.get("recipeBook") as? [String] ?? [],
                            signUpMethod: (document.get("signUpMethod") as? String ?? "")
                        )
                    }
                    
                    //If new user create new session
                    else {
                        self.currentUser = User(
                            uid: user.uid,
                            displayName:user.displayName,
                            email: user.email,
                            photoURL: user.photoURL?.absoluteString,
                            followers: [],
                            following: [],
                            recipeBook: [],
                            signUpMethod: ""
                        )
                    }
                }
                
            } else {
                self.currentUser = nil
            }
        })
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
        } catch {
            print("Error signing out")
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}
