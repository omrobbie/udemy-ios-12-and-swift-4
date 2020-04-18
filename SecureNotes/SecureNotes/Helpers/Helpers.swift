//
//  Helpers.swift
//  SecureNotes
//
//  Created by omrobbie on 19/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

func isNoteLocked(_ lockStatus: LockStatus) -> Bool {
    if lockStatus == .locked {
        return true
    } else {
        return false
    }
}

func lockStatusFlipper(_ lockStatus: LockStatus) -> LockStatus {
    if lockStatus == .locked {
        return .unlocked
    } else {
        return .locked
    }
}
