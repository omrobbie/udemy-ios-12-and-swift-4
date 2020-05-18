//
//  RoundedShadowImageView.swift
//  vision-app-dev
//
//  Created by omrobbie on 18/05/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class RoundedShadowImageView: UIImageView {

    override func awakeFromNib() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.75
        layer.cornerRadius = 15
    }
}
