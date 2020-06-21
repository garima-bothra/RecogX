//
//  String+isValidPhone.swift
//  RecogX
//
//  Created by Garima Bothra on 20/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import Foundation
import UIKit

extension String {
var isValidPhone: Bool {
    // Indian Numbering system 6000000000 to 9999999999
    let phoneNumberRegex = "^[6-9]\\d{9}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
    let isValidPhone = phoneTest.evaluate(with: self)
    return isValidPhone
}
    func heightNeededForLabel(_ label: UILabel) -> CGFloat {
    let width = label.frame.size.width
    guard let font = label.font else {return 0}
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
    return boundingBox.height
    }
}
