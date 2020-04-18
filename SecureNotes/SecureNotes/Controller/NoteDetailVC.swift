//
//  NoteDetailVC.swift
//  SecureNotes
//
//  Created by omrobbie on 19/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class NoteDetailVC: UIViewController {

    @IBOutlet weak var txtNote: UITextView!
    @IBOutlet weak var btnLock: UIButton!

    var note: Note!
    var index: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        txtNote.text = note.message

        if isNoteLocked(note.lockStatus) {
            btnLock.setTitle("UNLOCK NOTE", for: .normal)
        }
    }

    @IBAction func btnLockTapped(_ sender: Any) {
        notesArray[index].lockStatus = lockStatusFlipper(note.lockStatus)
        navigationController?.popViewController(animated: true)
    }
}
