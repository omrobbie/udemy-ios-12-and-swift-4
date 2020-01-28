//
//  PopVC.swift
//  pixel-city
//
//  Created by omrobbie on 28/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class PopVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var popImageView: UIImageView!

    var passedImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        popImageView.image = passedImage
        addDoubleTap()
    }

    func initData(forImage image: UIImage) {
        passedImage = image
    }

    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(screenWasDoubleTapped))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        view.addGestureRecognizer(doubleTap)
    }

    @objc func screenWasDoubleTapped() {
        dismiss(animated: true, completion: nil)
    }
}
