//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by omrobbie on 29/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!

    var goalType: GoalType = .shortTerm

    override func viewDidLoad() {
        super.viewDidLoad()
        goalTextView.delegate = self
        nextBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }

    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }

    @IBAction func longTermBtnWasPressed(_ sender: Any) {
        goalType = .longTerm
        shortTermBtn.setDeselectedColor()
        longTermBtn.setSelectedColor()
    }

    @IBAction func nextBtnWasPressed(_ sender: Any) {
        if goalTextView.text != "" && goalTextView.text != "What is your goal?" {
            guard let finishGoalVC = storyboard?.instantiateViewController(identifier: "finishGoalVC") as? FinishGoalVC else {return}

            finishGoalVC.initData(description: goalTextView.text, type: goalType)
            finishGoalVC.modalPresentationStyle = .fullScreen
            presentDetail(viewControllerToPresent: finishGoalVC)
        }
    }

    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
}

extension CreateGoalVC: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
