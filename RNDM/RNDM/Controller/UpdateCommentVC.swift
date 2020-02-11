//
//  UpdateCommentVC.swift
//  RNDM
//
//  Created by omrobbie on 11/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class UpdateCommentVC: UIViewController {

    @IBOutlet weak var commentTxt: TextViewPlaceholder!
    @IBOutlet weak var updateBtn: UIButton!

    var commentData: (comment: Comment, thought: Thought)!

    override func viewDidLoad() {
        super.viewDidLoad()
        commentTxt.layer.cornerRadius = 10.0
        updateBtn.layer.cornerRadius = 10.0

        commentTxt.text = commentData.comment.comment
    }

    @IBAction func updateBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
