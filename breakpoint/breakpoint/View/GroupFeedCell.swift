//
//  GroupFeedCell.swift
//  breakpoint
//
//  Created by omrobbie on 04/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!

    func configureCell(profileImage image: UIImage, email: String, content: String) {
        self.profileImage.image = image
        self.emailLbl.text = email
        self.contentLbl.text = content
    }
}
