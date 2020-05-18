//
//  CameraVC.swift
//  vision-app-dev
//
//  Created by omrobbie on 18/05/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class CameraVC: UIViewController {

    @IBOutlet weak var imgCaptured: UIImageView!
    @IBOutlet weak var btnFlash: UIButton!
    @IBOutlet weak var lblIdentification: UILabel!
    @IBOutlet weak var lblConfidence: UILabel!
    @IBOutlet weak var viewCamera: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
