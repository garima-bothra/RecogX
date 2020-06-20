//
//  FirebaseNetworking.swift
//  RecogX
//
//  Created by Garima Bothra on 20/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import Foundation
import Firebase
import SwiftyJSON
import FirebaseStorage

class firebaseNetworking {

    //MARK: - variables
    static let shared = firebaseNetworking()
    let database = Database.database().reference()
    static let storage = Storage.storage()
    let storageRef = storage.reference()
    let myUID = getUID()

// Initializing class
init() {
    let connectedRef = Database.database().reference(withPath: ".info/connected")
    connectedRef.observe(.value, with: { snapshot in
        if let connected = snapshot.value as? Bool , connected {
            // internet connected
            // later banner alert will be added
            print("Connected")
        } else {
            // internet disconnected
            // banner alert
            print("FUCK")
            self.database.removeAllObservers()
        }
    })
}
// deinitializing class
deinit {
    // remove all observer to free memory
    self.database.removeAllObservers()
}

    //MARK: - Function to fill the user form
       public func fillUserForm(param: Any,completion: @escaping (Bool) -> ()) {
           // setValue with param = ["name": "yourName", ....] type
           self.database.child("users").child(myUID).setValue(param) {
               (error:Error?, database:DatabaseReference) in
               if let error = error { // Error Handling
                   debugLog(message: "Data could not be saved: \(error).")
                   completion(false)
               } else {
                   debugLog(message: "Data saved successfully!")
                   completion(true)  // Completion handler
               }
           }
       }

    //MARK: - Upload file to storage
    public func uploadFile(fileURL: URL, completion: @escaping (Bool) -> ()) {
    let riversRef = storageRef.child("resume/\(getUID()).pdf")

    // Upload the file to the path "images/rivers.jpg"
    let uploadTask = riversRef.putFile(from: fileURL, metadata: nil) { metadata, error in
      guard let metadata = metadata else {
        // Uh-oh, an error occurred!
        debugPrint("ERROR WITH METADATA")
        completion(false)
        return
      }
      // Metadata contains file metadata such as size, content-type.
      let size = metadata.size
        completion(true)
      // You can also access to download URL after upload.
      riversRef.downloadURL { (url, error) in
        guard let downloadURL = url else {
          // Uh-oh, an error occurred!
          return
        }
      }
    }
    }
}
