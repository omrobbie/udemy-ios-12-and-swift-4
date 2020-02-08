//
//  CreateUserVC.swift
//  RNDM
//
//  Created by omrobbie on 08/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Firebase

class CreateUserVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func createBtnTapped(_ sender: Any) {
        guard let email = emailTxt.text,
            let password = passwordTxt.text,
            let username = usernameTxt.text else {return}

        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint("Error creating user: \(error.localizedDescription)")
                return
            }

            let changeRequest = user?.user.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges(completion: { (error) in
                if let error = error {
                    debugPrint("Error change username request: \(error.localizedDescription)")
                }
            })

            guard let userId = user?.user.uid else {return}

            Firestore.firestore().collection(USERS_REF).document(userId).setData([
                USERNAME: username,
                DATE_CREATED: FieldValue.serverTimestamp()
            ]) { (error) in
                if let error = error {
                    debugPrint("Error save user to firestore: \(error.localizedDescription)")
                    return
                }

                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    @IBAction func cancelBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
