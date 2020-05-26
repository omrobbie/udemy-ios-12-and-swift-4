//
//  RoundedVisualEffectView.swift
//  AnimalClassifierApp
//
//  Created by omrobbie on 26/05/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class RoundedVisualEffectView: UIVisualEffectView {

    override func awakeFromNib() {
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        clipsToBounds = true
    }
}
