//
//  AppDelegate+instantiate.swift
//  RecogX
//
//  Created by Garima Bothra on 20/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn

extension AppDelegate {

    //MARK: - Function setting up intial view controller
    func setInitialViewController() {

        // app delegate setup
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        // Get UID function
       // debugLog(message: getUID())

        let loginstatus = UserDefaults.standard.bool(forKey: "login")
        debugLog(message: "Login status=\(loginstatus)")
        if loginstatus == false {
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
        else if loginstatus == true {
            debugPrint("Already Logged In")
//            let tap = mainStoryboard.instantiateViewController(withIdentifier: "tapBar") as! UITabBarController
//            appDelegate.window?.rootViewController = tap
//            appDelegate.window?.makeKeyAndVisible()
        }
    }

}
