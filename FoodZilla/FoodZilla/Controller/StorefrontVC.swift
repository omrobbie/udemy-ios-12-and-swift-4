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
    }

    func iapLoadProducts() {
        IAPService.instance.delegate = self
        IAPService.instance.loadProducts()
    }

    @IBAction func restoreBtnWasTapped(_ sender: Any) {
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
