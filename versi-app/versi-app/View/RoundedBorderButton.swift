//
//  RoundedBorderButton.swift
//  versi-app
//
//  Created by omrobbie on 03/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class RoundedBorderButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 3
        layer.borderColor = UIColor.white.cgColor
    }
}
