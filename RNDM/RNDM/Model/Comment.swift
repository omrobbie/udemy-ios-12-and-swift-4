//
//  Comment.swift
//  RNDM
//
//  Created by omrobbie on 08/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

class Comment {

    private(set) var username: String!
    private(set) var timestamp: Date!
    private(set) var comment: String!

    init(username: String, timestamp: Date, comment: String) {
        self.username = username
        self.timestamp = timestamp
        self.comment = comment
    }
}
