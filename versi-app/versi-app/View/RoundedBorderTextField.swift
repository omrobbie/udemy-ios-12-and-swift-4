//
//  RoundedBorderTextField.swift
//  versi-app
//
//  Created by omrobbie on 03/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class RoundedBorderTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2784313725, green: 0.5490196078, blue: 0.9019607843, alpha: 1)])
        attributedPlaceholder = placeholder
        backgroundColor = .white
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 3
        layer.borderColor = #colorLiteral(red: 0.2784313725, green: 0.5490196078, blue: 0.9019607843, alpha: 1)

        borderStyle = .none
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
}
