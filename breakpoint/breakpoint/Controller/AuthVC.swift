//
//  AuthVC.swift
//  breakpoint
//
//  Created by omrobbie on 01/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func facebookSignInBtnWasPressed(_ sender: Any) {
    }

    @IBAction func googleSignInBtnWasPressed(_ sender: Any) {
    }

    @IBAction func signInWithEmailWasPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        loginVC?.modalPresentationStyle = .fullScreen
        present(loginVC!, animated: true, completion: nil)
    }
}
