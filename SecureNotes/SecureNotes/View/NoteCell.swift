//
//  NoteCell.swift
//  SecureNotes
//
//  Created by omrobbie on 19/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var imgLock: UIImageView!

    func parse(data: Note) {
        switch data.lockStatus {
        case .locked:
            lblMessage.text = "This note is locked! Unlock to read."
            imgLock.isHidden = false
        case .unlocked:
            lblMessage.text = data.message
            imgLock.isHidden = true
        }
    }
}
