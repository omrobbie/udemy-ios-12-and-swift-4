//
//  ViewController.swift
//  Binary
//
//  Created by omrobbie on 30/05/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtValue: UITextField!
    @IBOutlet weak var btnBinary: UIButton!
    @IBOutlet weak var btnDecimal: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldDidChange()
        txtValue.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        let binDigit = BinaryDecimal(145)
        print(binDigit.calculateBinaryValueForInt())
    }

    @objc func textFieldDidChange() {
        guard let isTextEmpty = txtValue.text?.isEmpty else {return}
        btnBinary.isEnabled = !isTextEmpty
        btnBinary.alpha = isTextEmpty ? 0.5 : 1.0
        btnDecimal.isEnabled = !isTextEmpty
        btnDecimal.alpha = isTextEmpty ? 0.5 : 1.0
    }

    @IBAction func btnBinaryTapped(_ sender: Any) {
    }

    @IBAction func btnDecimalTapped(_ sender: Any) {
    }
}
