//
//  firebaseSignOut.swift
//  RecogX
//
//  Created by Garima Bothra on 21/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn

extension UIViewController {
    func googleSignOut() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance().signOut()
            debugLog(message: "SignOut successful")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "login") as! ViewController
        appDelegate.window?.rootViewController = viewController
        appDelegate.window?.makeKeyAndVisible()
    }
}
