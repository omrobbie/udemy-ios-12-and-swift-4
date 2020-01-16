//
//  Product.swift
//  coder-swag
//
//  Created by omrobbie on 16/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

struct Product {

    private(set) var title: String
    private(set) var price: String
    private(set) var imageName: String

    init(title: String, price: String, imageName: String) {
        self.title = title
        self.price = price
        self.imageName = imageName
    }
}
