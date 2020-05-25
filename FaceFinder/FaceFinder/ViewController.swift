//
//  ViewController.swift
//  FaceFinder
//
//  Created by omrobbie on 25/05/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var lblMessage: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        setupImageView()
    }

    func setupImageView() {
        guard let image = UIImage(named: "face") else {return}
        let scaleHeight = (view.frame.width / image.size.width) * image.size.height

        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scaleHeight)
        view.addSubview(imageView)
    }
}
