//
//  DataService.swift
//  breakpoint
//
//  Created by omrobbie on 01/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

let DB_BASE = Database.database().reference()

class DataService {

    static let instance = DataService()

    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feeds")

    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }

    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }

    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }

    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }

    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }

    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool) -> ()) {
        if groupKey != nil {

        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
        }

    }
}
