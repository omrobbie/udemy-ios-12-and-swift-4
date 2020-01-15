//
//  SkillVC.swift
//  app-swoosh
//
//  Created by omrobbie on 15/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class SkillVC: UIViewController {

    var player: Player!

    @IBOutlet weak var finishBtn: BorderButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func selectSkill(skillLevel: String) {
        player.selectedSkillLevel = skillLevel
        finishBtn.isEnabled = true
    }

    @IBAction func onBeginnerTapped(_ sender: Any) {
        selectSkill(skillLevel: "beginner")
    }

    @IBAction func onBallerTapped(_ sender: Any) {
        selectSkill(skillLevel: "baller")
    }

    @IBAction func onFinishTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Player Information", message: "You are playing in \(player.desiredLeague!) league and you have \(player.selectedSkillLevel!) level", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
