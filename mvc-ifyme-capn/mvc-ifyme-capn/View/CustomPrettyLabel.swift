//
//  CustomPrettyLabel.swift
//  mvc-ifyme-capn
//
//  Created by omrobbie on 17/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

@IBDesignable
class CustomPrettyLabel: UILabel {

    override func prepareForInterfaceBuilder() {
        createView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        createView()
    }

    func createView() {
        backgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}
