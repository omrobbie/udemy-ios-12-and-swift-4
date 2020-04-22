//
//  ViewController.swift
//  Screenie
//
//  Created by omrobbie on 22/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var segPicker: UISegmentedControl!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var swtToggle: UISwitch!
    @IBOutlet weak var btnRecord: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func segPickerTapped(_ sender: UISegmentedControl) {
        var imgName = ""

        switch sender.selectedSegmentIndex {
        case 0: imgName = "skate"
        case 1: imgName = "food"
        case 2: imgName = "cat"
        case 3: imgName = "nature"
        default: break
        }

        imgSelected.image = UIImage(named: imgName)
    }

    @IBAction func btnRecord(_ sender: Any) {
    }
}
