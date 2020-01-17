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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appleProduct = AppleProduct(name: "iPhone X", color: "Space Gray", price: 999.99)

        iPhoneNameLabel.text = appleProduct.name
        iPhoneColorLabel.text = "in \(appleProduct.color)"
        iPhonePriceLabel.text = "$\(appleProduct.price)"
    }
}