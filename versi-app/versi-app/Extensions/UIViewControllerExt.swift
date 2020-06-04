//
//  UIViewControllerExt.swift
//  versi-app
//
//  Created by omrobbie on 04/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {

    func presentSFSafariVCFor(url: String) {
        let readmeUrl = URL(string: url + readmeSegment)
        let safariVC = SFSafariViewController(url: readmeUrl!)
        present(safariVC, animated: true)
    }
}
