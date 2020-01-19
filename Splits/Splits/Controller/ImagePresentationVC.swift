//
//  ImagePresentationVC.swift
//  Splits
//
//  Created by omrobbie on 20/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ImagePresentationVC: UIViewController {

    @IBOutlet weak var ItemImageView: UIImageView!

    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        ItemImageView.image = image
    }
}
