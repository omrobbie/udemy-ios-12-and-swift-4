//
//  AddThoughtVC.swift
//  RNDM
//
//  Created by omrobbie on 05/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtVC: UIViewController {

    @IBOutlet private weak var categorySegment: Ios12SegmentedControl!
    @IBOutlet private weak var userNameTxt: UITextField!
    @IBOutlet private weak var thoughtTxt: UITextView!
    @IBOutlet private weak var postBtn: UIButton!

    private var selectedCategory = ThoughtCategory.funny

    override func viewDidLoad() {
        super.viewDidLoad()
        postBtn.layer.cornerRadius = 4
        thoughtTxt.layer.cornerRadius = 4
    }

    @IBAction func categoryChanged(_ sender: Any) {
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny
        case 1:
            selectedCategory = ThoughtCategory.serious
        case 2:
            selectedCategory = ThoughtCategory.crazy
        default:
            selectedCategory = ThoughtCategory.popular
        }
    }

    @IBAction func postBtnTapped(_ sender: Any) {
        guard let username = userNameTxt.text else {return}

        Firestore.firestore().collection(THOUGHTS_REF).addDocument(data: [
            CATEGORY: selectedCategory,
            NUM_COMMENTS: 0,
            NUM_LIKES: 0,
            THOUGHT_TXT: thoughtTxt.text!,
            TIMESTAMP: FieldValue.serverTimestamp(),
            USERNAME: username
        ]) { (error) in
            if let error = error {
                debugPrint("Error add document: \(error.localizedDescription)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
