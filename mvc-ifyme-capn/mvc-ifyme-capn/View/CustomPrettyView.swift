//
//  CustomPettyView.swift
//  mvc-ifyme-capn
//
//  Created by omrobbie on 17/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class CustomPrettyView: UIView {

    override   func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 20
        layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.75
        backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        layer.borderWidth = 5
    }
}
