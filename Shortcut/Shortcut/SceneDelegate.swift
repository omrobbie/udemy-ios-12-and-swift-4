//
//  SceneDelegate.swift
//  Shortcut
//
//  Created by omrobbie on 19/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var vcs = [UIViewController]()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mountainsVC = storyboard.instantiateViewController(identifier: "MountainsVC") as! MountainsVC
        let spaceVC = storyboard.instantiateViewController(identifier: "SpaceVC") as! SpaceVC
        let oceanVC = storyboard.instantiateViewController(identifier: "OceanVC") as! OceanVC

        vcs = [mountainsVC, spaceVC, oceanVC]
    }

    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if let type = shortcutItem.type.components(separatedBy: ".").last {
            let navVC = window?.rootViewController as! UINavigationController
            navVC.setViewControllers(vcs, animated: false)

            switch type {
            case ShortcutType.mountains.rawValue:
                navVC.popToRootViewController(animated: true)
                completionHandler(true)
            case ShortcutType.space.rawValue:
                navVC.popToViewController(vcs[1], animated: true)
                completionHandler(true)
            case ShortcutType.ocean.rawValue:
                navVC.popToViewController(vcs[2], animated: true)
                completionHandler(true)
            default: break
            }

            completionHandler(false)
        }
    }
}
