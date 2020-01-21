//
//  CreateAccountVC.swift
//  Smack
//
//  Created by omrobbie on 21/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closeBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
}
