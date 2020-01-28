//
//  PopVC.swift
//  pixel-city
//
//  Created by omrobbie on 28/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class PopVC: UIViewController {

    @IBOutlet weak var popImageView: UIImageView!

    var passedImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        popImageView.image = passedImage
    }

    func initData(forImage image: UIImage) {
        passedImage = image
    }
}
