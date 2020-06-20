//
//  checkNetwork.swift
//  RecogX
//
//  Created by Garima Bothra on 20/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    internal func checkNewtork(ifError: String) {
        checkConnection { (status, statusCode) in
            if statusCode == 404{
                debugLog(message: "No connection!!")
                // Vibrates on errors
                UIDevice.invalidVibrate()
                self.networkErrorAlert(titlepass: ifError)
            }else{
                debugLog(message: "connection existing!!")
            }
        }
    }
}
