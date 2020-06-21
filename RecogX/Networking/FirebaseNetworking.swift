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

    //MARK: - Function to get User details
    public func getUser(completion: @escaping (Bool, User ) -> ()) {
        let userRef = self.database.child("users").child(getUID())
        var user = User(name: "", mail: "", phone: "")
        var community = Community(name: "", link: "", bio: "")
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            let userDict = snapshot.value as! [String: String]
            user.gender = userDict["gender"]
            user.mail = getEmail()
            user.name = userDict["name"] ?? "Garima"
            user.phone = userDict["phone"] ?? "7788996689"
            completion(true, user)
        }
    }

    //MARK: - Function to get Community details
    public func getCommunities(completion: @escaping (Bool, [Community] ) -> ()) {
        let communityRef = self.database.child("communities")
        var communityArr = [Community]()
        var community = Community(name: "", link: "", bio: "")
        communityRef.observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                community = Community(name: "", link: "", bio: "")
                let snap = child as! DataSnapshot
                let communityDict = snap.value as! [String: String]
                community.name = communityDict["name"]!
                community.link = communityDict["link"]!
                community.bio = communityDict["bio"]!
                communityArr.append(community)
            }
            completion(true, communityArr)
        }
    }

    //MARK: - Function to get Job details
       public func getJobs(completion: @escaping (Bool, [Job] ) -> ()) {
           let jobsRef = self.database.child("jobs")
           var jobsArr = [Job]()
        var job = Job(company: "", link: "", position: "", skills: "")
           jobsRef.observeSingleEvent(of: .value) { (snapshot) in
               for child in snapshot.children {
                   job = Job(company: "", link: "", position: "", skills: "")
                   let snap = child as! DataSnapshot
                   let communityDict = snap.value as! [String: String]
                job.company = communityDict["company"]!
                job.link = communityDict["link"]!
                job.position = communityDict["position"]!
                job.skills = communityDict["skills"]!
                jobsArr.append(job)
               }
               completion(true, jobsArr)
           }
       }

    //MARK: - Function to get Skills
       public func getSkills(completion: @escaping (Bool, [String] ) -> ()) {
        let skillsRef = self.database.child("resumes").child(getUID())
        skillsRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.hasChild("skills") {
                skillsRef.child("skills").observeSingleEvent(of: .childChanged) { (snapshot) in
                        var skills = [String]()
                         for child in snapshot.children {
                            let snap = child as! DataSnapshot
                            let skill = snap.value as! String
                            skills.append(skill)
                        }
                    print("SKILSS IN FUNC: \(skills)")
                        completion(true,skills)
                }
            } else {
                skillsRef.observeSingleEvent(of: .childAdded) { (snapshotChild) in
                    if snapshotChild.hasChild("skills"){
                    skillsRef.child("skills").observeSingleEvent(of: .value) { (snapshot) in
                        var skills = [String]()
                         for child in snapshot.children {
                            let snap = child as! DataSnapshot
                            let skill = snap.value as! String
                            skills.append(skill)
                        }
                        completion(true,skills)
                }
                    }
            }
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
        let resumesRef = self.database.child("resumes").child(getUID())
        resumesRef.child("link").setValue("\(riversRef)")
        resumesRef.child("uid").setValue(getUID())
        resumesRef.child("skills").setValue([""])
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
