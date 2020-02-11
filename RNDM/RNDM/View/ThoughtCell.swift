//
//  ThoughtCell.swift
//  RNDM
//
//  Created by omrobbie on 06/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

protocol ThoughtDelegate {
    func thoughtOptionsTapped(thought: Thought)
}


class ThoughtCell: UITableViewCell {

    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var thoughtTxtLbl: UILabel!
    @IBOutlet weak var likesImg: UIImageView!
    @IBOutlet weak var likesNumLbl: UILabel!
    @IBOutlet weak var commentsNumLbl: UILabel!
    @IBOutlet weak var optionMenu: UIImageView!
    
    private var thought: Thought!
    private var delegate: ThoughtDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        let tap = UITapGestureRecognizer(target: self, action: #selector(likeImgTapped))
        likesImg.addGestureRecognizer(tap)
        likesImg.isUserInteractionEnabled = true
    }

    @objc func likeImgTapped() {
//        Method 1
//        Firestore.firestore().collection(THOUGHTS_REF).document(thought.documentId).setData([NUM_LIKES: thought.numLikes + 1], merge: true)

//        Method 2
        Firestore.firestore().document("\(THOUGHTS_REF)/\(thought.documentId!)").updateData([NUM_LIKES: thought.numLikes + 1])
    }

    func configureCell(thought: Thought, delegate: ThoughtDelegate?) {
        self.delegate = delegate
        self.thought = thought
        usernameLbl.text = thought.username
        timestampLbl.text = thought.timestamp.toString(format: .shortDateTime)
        thoughtTxtLbl.text = thought.thoughtTxt
        likesNumLbl.text = String(thought.numLikes)
        commentsNumLbl.text = String(thought.numComments)
        optionMenu.isHidden = true

        if thought.userId == Auth.auth().currentUser?.uid {
            let tap = UITapGestureRecognizer(target: self, action: #selector(thoughtOptionsTapped))
            optionMenu.addGestureRecognizer(tap)
            optionMenu.isUserInteractionEnabled = true
            optionMenu.isHidden = false
        }
    }

    @objc func thoughtOptionsTapped() {
        delegate?.thoughtOptionsTapped(thought: thought)
    }
}
