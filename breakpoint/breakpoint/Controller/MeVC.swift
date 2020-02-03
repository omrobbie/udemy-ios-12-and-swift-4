//
//  MeVC.swift
//  breakpoint
//
//  Created by omrobbie on 03/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signOutBtnWasPressed(_ sender: Any) {
        let logOutPopup = UIAlertController(title: "Logout?", message: "Are you sure want to logout?", preferredStyle: .actionSheet)
        let logOutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
            do {
                try Auth.auth().signOut()

                let authVC = self.storyboard?.instantiateViewController(identifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            } catch {
                print("Error logging out: \(error.localizedDescription)")
            }
        }

        logOutPopup.addAction(logOutAction)
        present(logOutPopup, animated: true, completion: nil)
    }
}
