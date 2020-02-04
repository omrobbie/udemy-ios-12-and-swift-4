//
//  UIViewControllerExt.swift
//  breakpoint
//
//  Created by omrobbie on 04/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()

        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromRight
        view.window?.layer.add(transition, forKey: kCATransition)

        present(viewControllerToPresent, animated: false, completion: nil)
    }

    func dismissDetail() {
        let transition = CATransition()

        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromLeft
        view.window?.layer.add(transition, forKey: kCATransition)

        dismiss(animated: false, completion: nil)
    }
}
