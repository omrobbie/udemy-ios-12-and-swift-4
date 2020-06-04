//
//  SearchCell.swift
//  versi-app
//
//  Created by omrobbie on 04/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var viewCell: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblForks: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!

    var repoUrl: String?

    override func awakeFromNib() {
        viewCell.layer.cornerRadius = 15
    }

    func parseData(item: Repo) {
        lblName.text = item.name
        lblDescription.text = item.description
        lblForks.text = "\(item.numberOfForks)"
        lblLanguage.text = "\(item.language)"

        repoUrl = item.repoUrl
    }
}
