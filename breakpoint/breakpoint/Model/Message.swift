//
//  Message.swift
//  breakpoint
//
//  Created by omrobbie on 03/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

class Message {

    private var _content: String
    private var _senderId: String

    var content: String {
        return _content
    }

    var senderId: String {
        return _senderId
    }

    init(content: String, senderId: String) {
        _content = content
        _senderId = senderId
    }
}
