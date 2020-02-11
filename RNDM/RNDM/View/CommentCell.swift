//
//  CommentCell.swift
//  RNDM
//
//  Created by omrobbie on 08/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var optionMenu: UIImageView!
    
    func configureCell(comment: Comment) {
        usernameLbl.text = comment.username
        timestampLbl.text = comment.timestamp.toString(format: .shortDateTime)
        commentLbl.text = comment.comment
    }
}
