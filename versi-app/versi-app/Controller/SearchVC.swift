//
//  SearchVC.swift
//  versi-app
//
//  Created by omrobbie on 03/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var txtSearch: RoundedBorderTextField!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SearchCell else {return UITableViewCell()}
        return cell
    }
}
