//
//  debugger.swift
//  RecogX
//
//  Created by Garima Bothra on 20/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import Foundation

public func debugLog(message: String) {
    #if DEBUG
    debugPrint("=======================================")
    debugPrint(message)
    debugPrint("=======================================")
    #endif
}
