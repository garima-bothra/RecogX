//
//  KommunicateNetworking.swift
//  RecogX
//
//  Created by Garima Bothra on 20/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import Foundation
import Kommunicate

class kommunicateNetworking {
var kmUser = KMUser()
    static let shared = kommunicateNetworking()
    func registerUser() {
        if Kommunicate.isLoggedIn {
            print("LOGGED IN")
            return
        }
        print("WORKKK")
        kmUser.userId = Kommunicate.randomId()
        kmUser.displayName = appUser.name
        kmUser.email = getEmail()
        kmUser.applicationId = kommunication.AppID
        Kommunicate.registerUser(kmUser, completion: {
            response, error in
            guard error == nil else {return}
            print("Success")
        })
    }

    func logoutUser() {
        Kommunicate.logoutUser { (result) in
            switch result {
            case .success(_):
                print("Logout success")
            case .failure( _):
                print("Logout failure, now registering remote notifications(if not registered)")
                if !UIApplication.shared.isRegisteredForRemoteNotifications {
                    UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                        if granted {
                            DispatchQueue.main.async {
                                UIApplication.shared.registerForRemoteNotifications()
                            }
                        }
                    }
                }
            }
        }
    }
}
