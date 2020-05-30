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
    }

    @objc func textFieldDidChange() {
        guard let isTextEmpty = txtValue.text?.isEmpty else {return}
        btnBinary.isEnabled = !isTextEmpty
        btnBinary.alpha = isTextEmpty ? 0.5 : 1.0
        btnDecimal.isEnabled = !isTextEmpty
        btnDecimal.alpha = isTextEmpty ? 0.5 : 1.0
    }

    @IBAction func btnBinaryTapped(_ sender: Any) {
        guard let value = txtValue.text else {return}
        let binDigit = BinaryDecimal(Int(value) ?? 0)
        txtValue.text = binDigit.calculateBinaryValueForInt()
    }

    @IBAction func btnDecimalTapped(_ sender: Any) {
        guard let text = txtValue.text else {return}
        var binDigit: [Int] = []

        text.forEach {
            binDigit.append(Int(String($0)) ?? 0)
        }

        let int = BinaryDecimal(binDigit)
        txtValue.text = int.calculateIntValueForBinary()
    }
}
