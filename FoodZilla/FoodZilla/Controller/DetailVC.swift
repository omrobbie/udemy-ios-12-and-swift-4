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

    private(set) var item: Item!
    private var hiddenStatus: Bool = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseWasMade")

    override func viewDidLoad() {
        super.viewDidLoad()
        itemImage.image = item.image
        itemName.text = item.name
        itemPrice.text = String(describing: item.price)
        btnBuyItem.setTitle("Buy this item for $\(item.price)", for: .normal)

        NotificationCenter.default.addObserver(self, selector: #selector(handlePurchase(_:)), name: NSNotification.Name(IAPServicenPurchaseNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleFailure), name: NSNotification.Name(IAPServiceFailureNotification), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showOrHideAds()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    func initData(forItem item: Item) {
        self.item = item
    }

    func showOrHideAds() {
        uglyAdsView.isHidden = hiddenStatus
        btnHideAds.isHidden = hiddenStatus
    }

    @objc func handlePurchase(_ notification: Notification) {
        guard let productID = notification.object as? String else {return}

        switch productID {
        case IAP_MEAL_ID:
            btnBuyItem.isEnabled = true
            debugPrint("Meal successfully purchased.")
        case IAP_HIDE_ADS_ID:
            uglyAdsView.isHidden = true
            btnHideAds.isHidden = true
            debugPrint("Ads hidden!")
        default: break
        }
    }

    @objc func handleFailure() {
        btnBuyItem.isEnabled = true
        debugPrint("Purchase failed!")
    }

    @IBAction func btnBuyItemWasTapped(_ sender: Any) {
        btnBuyItem.isEnabled = false
        IAPService.instance.attemptPurchaseForItemWith(productIndex: .meal)
    }

    @IBAction func btnHideAdsWasTapped(_ sender: Any) {
        IAPService.instance.attemptPurchaseForItemWith(productIndex: .hideAds)
    }

    @IBAction func btnCloseWasTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
