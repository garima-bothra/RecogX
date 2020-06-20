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

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Do any additional setup after loading the view.
    }

    @IBAction func googleSignInButtonPressed(_ sender: Any) {
        checkNewtork(ifError: "Cannot login")
        GIDSignIn.sharedInstance().signIn()
    }

}

