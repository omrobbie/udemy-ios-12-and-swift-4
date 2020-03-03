//
//  ItemCell.swift
//  FoodZilla
//
//  Created by omrobbie on 03/03/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!

    func setupCell(forItem item: Item) {
        itemImage.image = item.image
        itemName.text = item.name
        itemPrice.text = String(describing: item.price)
    }
}
