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
import TwitterKit

class ViewController: UIViewController {

    @IBOutlet weak var userInfoLbl: UILabel!
    @IBOutlet weak var customGoogleBtn: UIButton!
    @IBOutlet var facebookLoginBtn: FBLoginButton!
    @IBOutlet weak var logoutBtn: UIButton!

    var loginManager = LoginManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        initGoogleButton()
        initFacebookButton()
        initTwitterButton()

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

    func initGoogleButton() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        customGoogleBtn.layer.cornerRadius = 5
    }

    func initFacebookButton() {
        facebookLoginBtn.delegate = self
        facebookLoginBtn.permissions = ["email"]

        for constraint in facebookLoginBtn.constraints where constraint.firstAttribute == .height {
            constraint.constant = 50
        }

//        other way to call facebook login button
//        let fbLoginButton = FBLoginButton()
//        fbLoginButton.delegate = self
//        fbLoginButton.frame = facebookLoginBtn.frame
//        view.addSubview(fbLoginButton)
    }

    func initTwitterButton() {
        let twitterButton = TWTRLogInButton { (session, error) in
            if let error = error {
                debugPrint("Error signing in with Twitter: \(error.localizedDescription)")
                return
            }

            guard let session = session else {return}
            let credential = TwitterAuthProvider.credential(withToken: session.authTokenSecret, secret: session.authTokenSecret)

            self.firebaseLogin(credential)
        }

        twitterButton.center = view.center
        view.addSubview(twitterButton)
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
                print("Google")
                GIDSignIn.sharedInstance()?.signOut()
            case TwitterAuthProviderID:
                print("Twitter")
            case FacebookAuthProviderID:
                print("Facebook")
                loginManager.logOut()
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

    @IBAction func customFacebookBtnTapped(_ sender: Any) {
        loginManager.logIn(permissions: ["email"], from: self) { (result, error) in
            if let error = error {
                debugPrint("Error signin in with Facebook: \(error.localizedDescription)")
                return
            }

            if result!.isCancelled {
                debugPrint("Facebook login is cancelled!")
                return
            }

            guard let accessToken = result?.token?.tokenString else {
                debugPrint("Error to get access token")
                return
            }

            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
            self.firebaseLogin(credential)
        }
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
        if let error = error {
            debugPrint("Error signing in with Facebook: \(error.localizedDescription)")
            return
        }

        guard let accessToken = result?.token?.tokenString else {
            debugPrint("Error to get access token!")
            return
        }

        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
        firebaseLogin(credential)
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
}
