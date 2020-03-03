//
//  Item.swift
//  FoodZilla
//
//  Created by omrobbie on 03/03/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class Item {

    private(set) var image: UIImage
    private(set) var name: String
    private(set) var price: Double

    init(image: UIImage, name: String, price: Double) {
        self.image = image
        self.name = name
        self.price = price
    }
}
