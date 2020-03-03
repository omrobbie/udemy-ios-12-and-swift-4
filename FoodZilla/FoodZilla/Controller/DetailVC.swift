//
//  DetailVC.swift
//  FoodZilla
//
//  Created by omrobbie on 03/03/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var uglyAdsView: UIView!
    @IBOutlet weak var btnBuyItem: UIButton!
    @IBOutlet weak var btnHideAds: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnBuyItemWasTapped(_ sender: Any) {
    }

    @IBAction func btnHideAdsWasTapped(_ sender: Any) {
    }

    @IBAction func btnCloseWasTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
