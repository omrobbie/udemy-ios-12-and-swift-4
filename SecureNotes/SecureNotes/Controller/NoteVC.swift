//
//  NoteVC.swift
//  SecureNotes
//
//  Created by omrobbie on 19/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import LocalAuthentication

class NoteVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func authenticationBiometrics(completion: @escaping (Bool) -> ()) {
        let context = LAContext()
        let localizedReasonString = "Our app users Touch ID / Face ID to secure your notes."
        var authError: NSError?

        if #available(iOS 8.0, macCatalyst 10.12.1, *) {
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReasonString) { (success, error) in
                    if success {
                        completion(true)
                    } else {
                        guard let evaluateErrorString = error?.localizedDescription else {return}
                        self.showAlert(withMessage: evaluateErrorString)
                        completion(false)
                    }
                }
            } else {
                guard let authErrorString = authError?.localizedDescription else {return}
                showAlert(withMessage: authErrorString)
            }
        } else {
            completion(false)
        }
    }

    func showAlert(withMessage message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default)
        alertVC.addAction(actionOk)
        present(alertVC, animated: true)
    }
}

extension NoteVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NoteCell
        cell.parse(data: notesArray[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "NoteDetailVC") as! NoteDetailVC
        vc.modalPresentationStyle = .fullScreen
        vc.note = notesArray[indexPath.row]
        vc.index = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}
