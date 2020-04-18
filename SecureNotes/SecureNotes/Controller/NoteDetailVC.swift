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

    var note: Note!
    var index: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        txtNote.text = note.message
    }

    @IBAction func btnLockTapped(_ sender: Any) {
        notesArray[index].lockStatus = .locked
        navigationController?.popViewController(animated: true)
    }
}
