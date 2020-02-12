//
//  ViewController.swift
//  FirebaseSocial
//
//  Created by omrobbie on 12/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {

    @IBOutlet weak var userInfoLbl: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        logoutBtn.layer.cornerRadius = 10
    }

    func firebaseLogin(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                debugPrint("Error login with firebase: \(error.localizedDescription)")
                return
            }
        }
    }

    @IBAction func googleSignInBtnTapped(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func logoutBtnTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()

        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            debugPrint("Error signing out from Firebase: \(signOutError.localizedDescription)")
        }
    }
}
