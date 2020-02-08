//
//  Comment.swift
//  RNDM
//
//  Created by omrobbie on 08/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation
import Firebase

class Comment {

    private(set) var username: String!
    private(set) var timestamp: Date!
    private(set) var comment: String!

    init(username: String, timestamp: Date, comment: String) {
        self.username = username
        self.timestamp = timestamp
        self.comment = comment
    }

    class func parseData(snapshot: QuerySnapshot?) -> [Comment] {
        var comments = [Comment]()
        guard let snapshot = snapshot else {return comments}

        for document in snapshot.documents {
            let data = document.data()

            let username = data[USERNAME] as? String ?? "Anonymous"
            let timestamp = data[TIMESTAMP] as? Date ?? Date()
            let comment = data[COMMENT] as? String ?? ""

            let newComment = Comment(username: username, timestamp: timestamp, comment: comment)
            comments.append(newComment)
        }

        return comments
    }
}
