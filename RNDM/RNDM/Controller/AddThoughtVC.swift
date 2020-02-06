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

    @IBOutlet weak var categorySegment: Ios12SegmentedControl!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var thoughtTxt: UITextView!
    @IBOutlet weak var postBtn: UIButton!

    private var selectedCategory = "funny"

    override func viewDidLoad() {
        super.viewDidLoad()
        postBtn.layer.cornerRadius = 4
        thoughtTxt.layer.cornerRadius = 4
    }

    @IBAction func categoryChanged(_ sender: Any) {
    }

    @IBAction func postBtnTapped(_ sender: Any) {
        Firestore.firestore().collection("thoughts").addDocument(data: [
            "category": selectedCategory,
            "numComments": 0,
            "numLikes": 0,
            "thoughtTxt": thoughtTxt.text!,
            "timestamp": FieldValue.serverTimestamp(),
            "username": userNameTxt.text!
        ]) { (error) in
            if let error = error {
                debugPrint("Error add document: \(error.localizedDescription)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
