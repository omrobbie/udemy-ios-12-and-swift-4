//
//  LeagueVC.swift
//  app-swoosh
//
//  Created by omrobbie on 15/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class LeagueVC: UIViewController {

    var player: Player!

    @IBOutlet weak var nextBtn: BorderButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        player = Player()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let skillVC = segue.destination as? SkillVC {
            skillVC.player = player
        }
    }

    func selectLeague(leagueType: String) {
        player.desiredLeague = leagueType
        nextBtn.isEnabled = true
    }

    @IBAction func onMensTapped(_ sender: Any) {
        selectLeague(leagueType: "mens")
    }

    @IBAction func onWomensTapped(_ sender: Any) {
        selectLeague(leagueType: "womens")
    }

    @IBAction func onCoedTapped(_ sender: Any) {
        selectLeague(leagueType: "coed")
    }

    @IBAction func onNextTapped(_ sender: Any) {
        performSegue(withIdentifier: "skillVCSegue", sender: self)
    }
}
