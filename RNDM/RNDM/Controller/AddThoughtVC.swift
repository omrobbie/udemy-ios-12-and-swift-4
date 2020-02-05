//
//  AddThoughtVC.swift
//  RNDM
//
//  Created by omrobbie on 05/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class AddThoughtVC: UIViewController {

    @IBOutlet weak var categorySegment: Ios12SegmentedControl!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var thoughtTxt: UITextView!
    @IBOutlet weak var postBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        postBtn.layer.cornerRadius = 4

        thoughtTxt.delegate = self
        thoughtTxt.layer.cornerRadius = 4
        thoughtTxt.text = "my random thought..."
        thoughtTxt.textColor = .lightGray
    }

    @IBAction func categoryChanged(_ sender: Any) {
    }

    @IBAction func postBtnTapped(_ sender: Any) {
    }
}

extension AddThoughtVC: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .darkGray
    }
}
