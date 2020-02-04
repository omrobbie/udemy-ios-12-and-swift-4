//
//  GroupFeedVC.swift
//  breakpoint
//
//  Created by omrobbie on 04/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    
    @IBOutlet weak var sendView: UIView!
    @IBOutlet weak var sendMessage: UITextField!
    @IBOutlet weak var sendBtn: UIButton!

    var group: Group?
    var groupMessages = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        sendView.bindToKeyboard()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitleLbl.text = group?.groupTitle

        DataService.instance.getEmailsFor(group: group!) { (returnedEmailArray) in
            self.membersLbl.text = returnedEmailArray.joined(separator: ", ")
        }

        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessageFor(desiredGroup: self.group!) { (returnedGroupMessages) in
                self.groupMessages = returnedGroupMessages
                self.tableView.reloadData()
            }
        }
    }

    func initData(forGroup group: Group) {
        self.group = group
    }

    @IBAction func sendBtnWasPressed(_ sender: Any) {
        if sendMessage.text != "" {
            sendMessage.isEnabled = false
            sendBtn.isEnabled = false

            DataService.instance.uploadPost(withMessage: sendMessage.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: group?.key) { (complete) in
                if complete {
                    self.sendMessage.text = ""
                    self.sendMessage.isEnabled = true
                    self.sendBtn.isEnabled = true
                }
            }
        }
    }

    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell") as? GroupFeedCell else {return UITableViewCell()}
        let profileImage = #imageLiteral(resourceName: "defaultProfileImage")
        let item = groupMessages[indexPath.row]

        print(item.content)

        DataService.instance.getUsername(forUID: item.senderId) { (email) in
            cell.configureCell(profileImage: profileImage, email: email, content: item.content)
        }

        return cell
    }
}
