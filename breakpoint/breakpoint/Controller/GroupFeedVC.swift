//
//  GroupFeedVC.swift
//  breakpoint
//
//  Created by omrobbie on 04/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    
    @IBOutlet weak var sendView: UIView!
    @IBOutlet weak var sendMessage: UIView!
    @IBOutlet weak var sendBtn: UIView!

    var group: Group?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        sendView.bindToKeyboard()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitleLbl.text = group?.groupTitle
        membersLbl.text = group?.members.joined(separator: ", ")
    }

    func initData(forGroup group: Group) {
        self.group = group
    }

    @IBAction func sendBtnWasPressed(_ sender: Any) {
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
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell") as? GroupFeedCell else {return UITableViewCell()}
        let profileImage = #imageLiteral(resourceName: "defaultProfileImage")

        cell.configureCell(profileImage: profileImage, email: "dummy@email.com", content: "Dummy content")

        return cell
    }
}
