//
//  AppDelegate.swift
//  FirebaseSocial
//
//  Created by omrobbie on 12/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        initGoogle()
        initFacebook(application, launchOptions)
        initTwitter()

        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let google = GIDSignIn.sharedInstance()?.handle(url) else {return false}
        let facebook = ApplicationDelegate.shared.application(app, open: url, options: options)
        let twitter = TWTRTwitter.sharedInstance().application(app, open: url, options:     options)

        return google || facebook || twitter
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            debugPrint("Error sign in with Google: \(error.localizedDescription)")
            return
        }

        guard let controller = GIDSignIn.sharedInstance()?.presentingViewController as? ViewController else {return}
        guard let authentication = user.authentication else {return}
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)

        controller.firebaseLogin(credential)
    }

    func initGoogle() {
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
    }

    func initFacebook(_ application: UIApplication, _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func initTwitter() {
        let key = Bundle.main.object(forInfoDictionaryKey: "twitterKey")
        let secret = Bundle.main.object(forInfoDictionaryKey: "twitterSecret")

        if let key = key as? String, let secret = secret as? String {
            TWTRTwitter.sharedInstance().start(withConsumerKey: key, consumerSecret: secret)
        }
    }
}
