//
//  NoteObjects.swift
//  SecureNotes
//
//  Created by omrobbie on 19/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

var note1 = Note(message: "Hello there! I'm omrobbie and I do some amazing iOS Apps Development. You can find me at omrobbie.com", lockStatus: .locked)
var note2 = Note(message: "In this app we learn about how to use Touch ID and Face ID from Apple Framework. Check it out!", lockStatus: .unlocked)
var note3 = Note(message: "Found dead end?! You can always find an answer in Internet. Keep going!", lockStatus: .locked)

var notesArray: [Note] = [
    note1,
    note2,
    note3
]
