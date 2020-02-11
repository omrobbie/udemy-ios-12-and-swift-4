//
//  CommentCell.swift
//  RNDM
//
//  Created by omrobbie on 08/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

protocol CommentDelegate {
    func commentOptionsTapped(comment: Comment)
}

class CommentCell: UITableViewCell {

    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var optionMenu: UIImageView!

    private var comment: Comment!
    private var delegate: CommentDelegate?

    func configureCell(comment: Comment, delegate: CommentDelegate?) {
        self.delegate = delegate
        self.comment = comment
        usernameLbl.text = comment.username
        timestampLbl.text = comment.timestamp.toString(format: .shortDateTime)
        commentLbl.text = comment.comment
        optionMenu.isHidden = true

        if comment.userId == Auth.auth().currentUser?.uid {
            let tap = UITapGestureRecognizer(target: self, action: #selector(commentOptionsTapped))
            optionMenu.addGestureRecognizer(tap)
            optionMenu.isUserInteractionEnabled = true
            optionMenu.isHidden = false
        }
    }

    @objc func commentOptionsTapped() {
        delegate?.commentOptionsTapped(comment: comment)
    }
}
