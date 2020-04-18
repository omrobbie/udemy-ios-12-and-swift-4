//
//  StorefrontVC.swift
//  FoodZilla
//
//  Created by omrobbie on 03/03/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class StorefrontVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        iapLoadProducts()
    }

    func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self

        NotificationCenter.default.addObserver(self, selector: #selector(showRestoredAlert), name: NSNotification.Name(IAPServiceRestoreNotification), object: nil)
    }

    func iapLoadProducts() {
        IAPService.instance.delegate = self
        IAPService.instance.loadProducts()
    }

    @objc func showRestoredAlert() {
        let alertVC = UIAlertController(title: "Success!", message: "Your purchases were successfully restored.", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default)

        alertVC.addAction(actionOk)
        present(alertVC, animated: true)
    }

    @IBAction func subscribeBtnWasTapped(_ sender: Any) {
        IAPService.instance.attemptPurchaseForItemWith(productIndex: .mealMonthly)
    }

    @IBAction func restoreBtnWasTapped(_ sender: Any) {
        let alertVC = UIAlertController(title: "Restore Purchases?", message: "Do you want to restore any in-app purchases you've previously purchased?", preferredStyle: .actionSheet)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)

        let actionRestore = UIAlertAction(title: "Restore", style: .default) { (_) in
            IAPService.instance.restorePurcases()
        }

        alertVC.addAction(actionRestore)
        alertVC.addAction(actionCancel)

        present(alertVC, animated: true)
    }
}

extension StorefrontVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCell else {return UICollectionViewCell()}
        cell.setupCell(forItem: foodItems[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.initData(forItem: foodItems[indexPath.row])
        present(vc, animated: true, completion: nil)
    }
}

extension StorefrontVC: IAPServiceDelegate {

    func iapProductsLoaded() {
        print("IAP Products Loaded!")
    }
}
