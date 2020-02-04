//
//  CreateGroupVC.swift
//  breakpoint
//
//  Created by omrobbie on 04/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class CreateGroupVC: UIViewController {

    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var emailSearchTextField: InsetTextField!

    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func doneBtnWasPressed(_ sender: Any) {
    }

    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
