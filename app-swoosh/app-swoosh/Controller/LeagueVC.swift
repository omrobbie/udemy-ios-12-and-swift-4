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

    @IBAction func onMensTapped(_ sender: Any) {
        player.desiredLeague = "mens"
        nextBtn.isEnabled = true
    }

    @IBAction func onWomensTapped(_ sender: Any) {
        player.desiredLeague = "womens"
        nextBtn.isEnabled = true
    }

    @IBAction func onCoedTapped(_ sender: Any) {
        player.desiredLeague = "coed"
        nextBtn.isEnabled = true
    }

    @IBAction func onNextTapped(_ sender: Any) {
        performSegue(withIdentifier: "skillVCSegue", sender: self)
    }
}
