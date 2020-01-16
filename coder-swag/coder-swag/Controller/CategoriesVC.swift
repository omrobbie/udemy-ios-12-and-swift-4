//
//  ViewController.swift
//  coder-swag
//
//  Created by omrobbie on 16/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var categoryTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        categoryTable.delegate = self
        categoryTable.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getCategories().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell {
            let items = DataService.instance.getCategories()[indexPath.row]
            cell.updateViews(category: items)

            return cell
        } else {
            return CategoryCell()
        }
    }
}
