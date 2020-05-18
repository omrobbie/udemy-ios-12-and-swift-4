//
//  CameraVC.swift
//  vision-app-dev
//
//  Created by omrobbie on 18/05/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class CameraVC: UIViewController {

    @IBOutlet weak var imgCaptured: RoundedShadowImageView!
    @IBOutlet weak var btnFlash: RoundedShadowButton!
    @IBOutlet weak var lblIdentification: UILabel!
    @IBOutlet weak var lblConfidence: UILabel!
    @IBOutlet weak var viewCamera: RoundedShadowView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
