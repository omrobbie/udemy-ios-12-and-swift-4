//
//  TrendingRepoCell.swift
//  versi-app
//
//  Created by omrobbie on 03/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class TrendingRepoCell: UITableViewCell {

    @IBOutlet weak var viewRepo: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescriptions: UILabel!
    @IBOutlet weak var imgRepo: UIImageView!
    @IBOutlet weak var lblForks: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblContributors: UILabel!

    override func layoutSubviews() {
        viewRepo.layer.cornerRadius = 15
        viewRepo.layer.shadowColor = UIColor.black.cgColor
        viewRepo.layer.shadowOpacity = 0.25
        viewRepo.layer.shadowRadius = 5
        viewRepo.layer.shadowOffset = CGSize(width: 0, height: 0)
    }

    func parseData(item: Repo) {
        self.lblName.text = item.name
        self.lblDescriptions.text = item.description
        self.imgRepo.image = item.image
        self.lblForks.text = "\(item.numberOfForks)"
        self.lblLanguage.text = item.language
        self.lblContributors.text = "\(item.numberOfContributors)"
    }
}
