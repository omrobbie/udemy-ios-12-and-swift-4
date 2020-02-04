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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension GroupVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupCell else {return UITableViewCell()}

        cell.configureCell(title: "Dummy title", description: "Dummy description", memberCount: 3)

        return cell
    }


}
