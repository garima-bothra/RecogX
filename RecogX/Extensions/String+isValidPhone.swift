//
//  String+isValidPhone.swift
//  RecogX
//
//  Created by Garima Bothra on 20/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import Foundation

extension String {
var isValidPhone: Bool {
    // Indian Numbering system 6000000000 to 9999999999
    let phoneNumberRegex = "^[6-9]\\d{9}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
    let isValidPhone = phoneTest.evaluate(with: self)
    return isValidPhone
}
}
