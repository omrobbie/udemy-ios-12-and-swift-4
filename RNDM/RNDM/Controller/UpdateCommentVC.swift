//
//  UpdateCommentVC.swift
//  RNDM
//
//  Created by omrobbie on 11/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Firebase

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
        let thoughtRef = Firestore.firestore().collection(THOUGHTS_REF).document(commentData.thought.documentId)
        let commentRef = thoughtRef.collection(COMMENTS_REF).document(commentData.comment.documentId)

        commentRef.updateData([
            COMMENT: commentTxt.text ?? ""
        ]) { (error) in
            if let error = error {
                debugPrint("Error update comment: \(error.localizedDescription)")
                return
            }

            self.dismiss(animated: true, completion: nil)
        }
    }
}
