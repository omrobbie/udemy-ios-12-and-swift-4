//
//  ViewController.swift
//  mvc-ifyme-capn
//
//  Created by omrobbie on 17/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class Controller: UIViewController {

    @IBOutlet weak var iPhoneNameLabel: UILabel!
    @IBOutlet weak var iPhoneColorLabel: UILabel!
    @IBOutlet weak var iPhonePriceLabel: UILabel!
    @IBOutlet weak var customPrettyView: CustomPrettyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appleProduct = AppleProduct(name: "iPhone X", color: "Space Gray", price: 999.99)

        iPhoneNameLabel.text = appleProduct.name
        iPhoneColorLabel.text = "in \(appleProduct.color)"
        iPhonePriceLabel.text = "$\(appleProduct.price)"

        addLabelProgrammatically()
    }

    func addLabelProgrammatically() {
        let label = UILabel(frame: CGRect(x: 0, y: customPrettyView.frame.maxY + 50, width: view.frame.width, height: 64))
        label.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.text = "omrobbie"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 32.0)

        view.addSubview(label)
    }
}
