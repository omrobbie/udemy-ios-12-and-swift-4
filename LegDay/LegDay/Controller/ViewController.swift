//
//  ViewController.swift
//  LegDay
//
//  Created by omrobbie on 19/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Intents

class ViewController: UIViewController {

    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblTimer: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSiri()
    }

    fileprivate func setupUI() {
        lblType.isHidden = true
        lblTimer.isHidden = true
    }

    fileprivate func setupSiri() {
        INPreferences.requestSiriAuthorization { (status) in
            if status == INSiriAuthorizationStatus.authorized {
                debugPrint("SiriKit: Authorized")
            } else {
                debugPrint("SiriKit: Unauthorized")
            }
        }
    }
}
