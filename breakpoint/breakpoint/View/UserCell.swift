//
//  UserCell.swift
//  breakpoint
//
//  Created by omrobbie on 04/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var profilImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var checkImage: UIImageView!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool) {
        self.profilImage.image = image
        self.emailLbl.text = email

        if isSelected {
            checkImage.isHidden = false
        } else {
            checkImage.isHidden = true
        }
    }
}
