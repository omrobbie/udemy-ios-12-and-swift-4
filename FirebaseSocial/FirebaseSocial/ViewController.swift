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
import FBSDKLoginKit

class ViewController: UIViewController {

    @IBOutlet weak var userInfoLbl: UILabel!
    @IBOutlet weak var customGoogleBtn: UIButton!
    @IBOutlet var facebookLoginBtn: FBLoginButton!
    @IBOutlet weak var logoutBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self

//        let fbLoginButton = FBLoginButton()
//        fbLoginButton.delegate = self
//        fbLoginButton.frame = facebookLoginBtn.frame
//        view.addSubview(fbLoginButton)

//        facebookLoginBtn.delegate = self

        customGoogleBtn.layer.cornerRadius = 5
        logoutBtn.layer.cornerRadius = 10
    }

    override func viewDidAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                self.userInfoLbl.text = "No user logged in"
            } else {
                let currentUser = Auth.auth().currentUser
                self.userInfoLbl.text = "Welcome user: \(currentUser?.displayName ?? "")"
            }
        }
    }

    func firebaseLogin(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                debugPrint("Error login with firebase: \(error.localizedDescription)")
                return
            }
        }
    }

    func logoutSocial() {
        guard let user = Auth.auth().currentUser else {return}

        for info in user.providerData {
            switch info.providerID {
            case GoogleAuthProviderID:
                GIDSignIn.sharedInstance()?.signOut()
                print("Google")
            case TwitterAuthProviderID:
                print("Twitter")
            case FacebookAuthProviderID:
                print("Facebook")
            default:
                break
            }
        }
    }

    @IBAction func googleSignInBtnTapped(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func customGoogleBtnTapped(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }

    @IBAction func logoutBtnTapped(_ sender: Any) {
        do {
            logoutSocial()
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            debugPrint("Error signing out from Firebase: \(signOutError.localizedDescription)")
        }
    }
}

extension ViewController: LoginButtonDelegate {

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
}
