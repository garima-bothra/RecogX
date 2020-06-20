//
//  getFirebaseUser.swift
//  RecogX
//
//  Created by Garima Bothra on 20/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import Foundation
import Firebase

//MARK: - User
var appUser = User(name: "", mail: "", phone: "")

//MARK: -  function to get uid
internal func getUID() -> String {
    let uid = Auth.auth().currentUser?.uid
    return uid ?? "notFound"
}

//MARK: -  function to get Registred Email
internal func getEmail() -> String {
    let userEmail = Auth.auth().currentUser?.email
    return userEmail ?? "notFound"
}
