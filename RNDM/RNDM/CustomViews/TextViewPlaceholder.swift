//
//  TextViewPlaceholder.swift
//  RNDM
//
//  Created by omrobbie on 05/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

@IBDesignable
class TextViewPlaceholder: UITextView, UITextViewDelegate {

    @IBInspectable
    var placeholder: String = ""

    @IBInspectable
    var placeholderColor: UIColor = .lightGray

    private var color: UIColor = .black

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }

    func setup() {
        delegate = self
        color = textColor ?? .black

        if placeholder != "" {
            text = placeholder
            textColor = placeholderColor
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if text == placeholder {
            text = ""
            textColor = color
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if text == "" {
            text = placeholder
            textColor = placeholderColor
        }
    }
}
