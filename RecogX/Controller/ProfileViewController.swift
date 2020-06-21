//
//  ProfileViewController.swift
//  RecogX
//
//  Created by Garima Bothra on 21/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var userProfile = User(name: "", mail: "", phone: "")
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!

    fileprivate func getUserData() {
        firebaseNetworking.shared.getUser() { (completion, profile) in
            if completion == true {
                self.userProfile = profile
                if profile.gender == "Male" {
                    self.profileImageView.image = #imageLiteral(resourceName: "avatar-3637425_1280")
                } else if profile.gender == "Female" {
                    self.profileImageView.image = #imageLiteral(resourceName: "teacher-295387_1280")
                } else {
                    self.profileImageView.image == #imageLiteral(resourceName: "man-303792_1280")
                }
                self.setup()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
        // Do any additional setup after loading the view.
    }

    func setup() {
        nameLabel.text = "Name: \(userProfile.name)"
        mailLabel.text = "Email: \(userProfile.mail)"
        phoneLabel.text = "Phone: \(userProfile.phone)"
        logoutButton.layer.cornerRadius = 10
        self.navigationItem.largeTitleDisplayMode = .never
    }

    @IBAction func logoutButtonPressed(_ sender: Any) {
        googleSignOut()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
