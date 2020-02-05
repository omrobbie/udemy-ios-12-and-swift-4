//
//  Ios12SegmentedControl.swift
//  RNDM
//
//  Created by omrobbie on 05/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

@IBDesignable
class Ios12SegmentedControl: UISegmentedControl {

    @IBInspectable
    var color: UIColor = .link {
        didSet {
            tintColor = color
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }

    func setup() {
        if #available(iOS 13, *) {
            let _background = UIImage(color: .clear, size: CGSize(width: 1, height: 32))
            let _divider = UIImage(color: color, size: CGSize(width: 1, height: 32))

            //set background images
            setBackgroundImage(_background, for: .normal, barMetrics: .default)
            setBackgroundImage(_divider, for: .selected, barMetrics: .default)

            //set divider color
            setDividerImage(_divider, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)

            //set border
            layer.borderWidth = 1
            layer.borderColor = color.cgColor
        } else {
            selectedSegmentTintColor = color
        }

        //set label color
        setTitleTextAttributes([.foregroundColor: color], for: .normal)
        setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.set()
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        self.init(data: image.pngData()!)!
    }
}
