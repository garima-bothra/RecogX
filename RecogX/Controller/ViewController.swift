//
//  ViewController.swift
//  RecogX
//
//  Created by Garima Bothra on 20/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {

    @IBOutlet weak var ourMissionLabel: UILabel!
    @IBOutlet weak var googleButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        googleButton.layer.cornerRadius = 10
        ourMissionLabel.text = "🦄 Development: Help you make your mark in the tech field \n\n 🦄 Inclusion: Everyone matters and matters equally. \n\n 🦄 Empowerment: Finding opportunities for all and help them grow in tech. \n\n 🦄 Diversity: Our differences spark innovation and bringing everyone together under the same roof.  \n\n 🦄 Making a difference: Making a positive change in the world with access to opportunity "
        // Do any additional setup after loading the view.
    }

    @IBAction func googleSignInButtonPressed(_ sender: Any) {
        checkNewtork(ifError: "Cannot login")
        GIDSignIn.sharedInstance().signIn()
    }

}

