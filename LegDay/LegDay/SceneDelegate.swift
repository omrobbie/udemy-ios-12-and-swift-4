//
//  SceneDelegate.swift
//  LegDay
//
//  Created by omrobbie on 19/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Intents

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        guard let intent = userActivity.interaction?.intent as? INStartWorkoutIntent else {
            debugPrint("Scene: Start workout intent - False")
            return
        }

        DataService.instance.startWorkoutIntent = intent
        NotificationCenter.default.post(name: NSNotification.Name("workoutStartedNotification"), object: nil)

        print("Scene: Start workout intent - True")
        print(intent)
    }
}
