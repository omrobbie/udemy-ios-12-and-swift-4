//
//  GoalCell.swift
//  goalpost-app
//
//  Created by omrobbie on 29/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!

    func configureCell(description: String, type: String, progress: Int) {
        self.goalDescriptionLbl.text = description
        self.goalTypeLbl.text = type
        self.goalProgressLbl.text = String(describing: progress)
    }
}
