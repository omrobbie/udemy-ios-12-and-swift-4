//
//  ViewController.swift
//  window-shopper
//
//  Created by omrobbie on 16/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var wageTxt: CurrencyTextField!
    @IBOutlet weak var priceTxt: CurrencyTextField!
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var hoursLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let calcBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 64))
        calcBtn.backgroundColor = #colorLiteral(red: 0.8898937106, green: 0.5137273073, blue: 0.009626680054, alpha: 1)
        calcBtn.setTitle("Calculate", for: .normal)
        calcBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        calcBtn.addTarget(self, action: #selector(MainVC.calculate), for: .touchUpInside)

        wageTxt.inputAccessoryView = calcBtn
        priceTxt.inputAccessoryView = calcBtn

        resultLbl.isHidden = true
        hoursLbl.isHidden = true
    }

    @objc func calculate() {
        if let wageTxt = wageTxt.text,
            let priceTxt = priceTxt.text {
            if let wage = Double(wageTxt),
                let price = Double(priceTxt) {
                view.endEditing(true)

                resultLbl.isHidden = false
                hoursLbl.isHidden = false

                resultLbl.text = "\(Wage.getHours(forWage: wage, andPrice: price))"
            }
        }

    }

    @IBAction func clearCalculatorTapped(_ sender: Any) {
        wageTxt.text = ""
        priceTxt.text = ""

        resultLbl.isHidden = true
        hoursLbl.isHidden = true
    }
}
