//
//  CreatePostVC.swift
//  breakpoint
//
//  Created by omrobbie on 03/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.inputAccessoryView = sendBtn
    }

    @IBAction func sendBtnWasPressed(_ sender: Any) {
        if textView.text != "" && textView.text != "Say something here..." {
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil) { (isComplete) in
                if isComplete {
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.sendBtn.isEnabled = true
                    print("There is an error while uploading post!")
                }
            }
        }
    }

    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreatePostVC: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
