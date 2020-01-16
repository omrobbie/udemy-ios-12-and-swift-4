//
//  CurrencyTextField.swift
//  window-shopper
//
//  Created by omrobbie on 16/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

@IBDesignable
class CurrencyTextField: UITextField {

    override func prepareForInterfaceBuilder() {
        customizeView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }

    override func draw(_ rect: CGRect) {
        let size: CGFloat = 20
        let currencyLbl = UILabel(frame: CGRect(x: 5, y: (frame.size.height / 2) - size / 2, width: size, height: size))

        currencyLbl.backgroundColor = #colorLiteral(red: 0.8782122731, green: 0.8783598542, blue: 0.878192842, alpha: 0.8017440581)
        currencyLbl.textAlignment = .center
        currencyLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        currencyLbl.layer.cornerRadius = 5.0
        currencyLbl.clipsToBounds = true

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current

        currencyLbl.text = formatter.currencySymbol
        addSubview(currencyLbl)
    }

    func customizeView() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.25)
        layer.cornerRadius = 5.0
        clipsToBounds = true

        textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textAlignment = .center

        if let p = placeholder {
            let place = NSAttributedString(string: p, attributes: [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
            attributedPlaceholder = place
        }
    }
}
