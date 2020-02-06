//
//  Thought.swift
//  RNDM
//
//  Created by omrobbie on 06/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

class Thought {

    private(set) var documentId: String!
    private(set) var category: String!
    private(set) var numComments: Int!
    private(set) var numLikes: Int!
    private(set) var thoughtTxt: String!
    private(set) var timestamp: Date!
    private(set) var username: String!

    init(documentId: String, category: String, numComments: Int, numLikes: Int, thoughtTxt: String, timestamp: Date, username: String) {
        self.documentId = documentId
        self.category = category
        self.numComments = numComments
        self.numLikes = numLikes
        self.thoughtTxt = thoughtTxt
        self.timestamp = timestamp
        self.username = username
    }
}
