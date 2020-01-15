//
//  BorderButton.swift
//  app-swoosh
//
//  Created by omrobbie on 14/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class BorderButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.white.cgColor
    }
}
