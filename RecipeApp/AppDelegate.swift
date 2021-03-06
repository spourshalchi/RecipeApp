//
//  AppDelegate.swift
//  RecipeApp
//
//  Created by Scott Pourshalchi on 3/20/20.
//  Copyright © 2020 Scott Pourshalchi. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseFirestore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        //Error
        if let error = error {
            print(error.localizedDescription)
            return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (res, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            //Saves the login status to persistent memory
            UserDefaults.standard.set(true, forKey: "status")
            
            //Add user info to database
            let db = Firestore.firestore()
            let docRef = db.collection("users").document(String((res?.user.uid)!))
            docRef.getDocument { (document, error) in
                
                //If user is already in the db only update the fields that we want to change
                if let document = document, document.exists {
                    docRef.setData([
                        "id" : String((res?.user.uid)!),
                        "displayName" : (res?.user.displayName)!,
                        "photoURL" : (res?.user.photoURL?.absoluteString)!,
                        "email" : (res?.user.email)!,
                        "signUpMethod" : "Google"
                    ], merge: true)
                }
                
                //If user is not in the db yet create all new fields 
                else {
                    docRef.setData([
                        "id" : String((res?.user.uid)!),
                        "displayName" : (res?.user.displayName)!,
                        "photoURL" : (res?.user.photoURL?.absoluteString)!,
                        "email" : (res?.user.email)!,
                        "followers" : [],
                        "following" : [],
                        "recipeBook" : [],
                        "signUpMethod" : "Google"
                    ], merge: true)
                }
            }
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

