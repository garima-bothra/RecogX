//
//  ViewController+Alert.swift
//  RecogX
//
//  Created by Garima Bothra on 20/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    //MARK: - ALERT function for network connection
    internal func networkErrorAlert(titlepass : String) {
        // Vibrates on errors
        UIDevice.invalidVibrate()
        let alert = UIAlertController(title: titlepass, message: "No internet connection available.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            let settingsUrl = NSURL(string: UIApplication.openSettingsURLString)
            if let url = settingsUrl {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    //MARK: - ALERT function for Authentication
    internal func authAlert(titlepass: String,message: String) {
        // Vibrates on errors
        UIDevice.invalidVibrate()
        let alert = UIAlertController(title: titlepass, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert,animated: true,completion: nil)
    }

    //MARK: - ALERT to dismiss the View Controller
    internal func dismissAlert(titlepass: String,message: String) {
        let alert = UIAlertController(title: titlepass, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert,animated: true,completion: nil)
    }

    internal func dismissViewAlert(titlepass: String,message: String) {
        let alert = UIAlertController(title: titlepass, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert,animated: true,completion: nil)
    }

}
