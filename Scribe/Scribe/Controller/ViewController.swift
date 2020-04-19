//
//  ViewController.swift
//  Scribe
//
//  Created by omrobbie on 19/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var txtTranscribe: UITextView!
    @IBOutlet weak var btnRecord: CircleButton!
    @IBOutlet weak var activityRecord: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnRecordTapped(_ sender: Any) {
    }
}
