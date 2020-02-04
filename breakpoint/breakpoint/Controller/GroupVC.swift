//
//  SecondViewController.swift
//  breakpoint
//
//  Created by omrobbie on 01/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class GroupVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var groupArray = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DataService.instance.getAllGroup { (returnedGroupArray) in
            self.groupArray = returnedGroupArray
            self.tableView.reloadData()
        }
    }
}

extension GroupVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupCell else {return UITableViewCell()}
        let item = groupArray[indexPath.row]

        cell.configureCell(title: item.groupTitle, description: item.groupDesc, memberCount: item.memberCount)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(identifier: "GroupFeedVC") as? GroupFeedVC else {return}
        groupFeedVC.modalPresentationStyle = .fullScreen
        present(groupFeedVC, animated: true, completion: nil)
    }
}
