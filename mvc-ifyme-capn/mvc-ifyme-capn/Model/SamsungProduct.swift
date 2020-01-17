//
//  SamsungProduct.swift
//  mvc-ifyme-capn
//
//  Created by omrobbie on 17/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

struct SamsungProduct {

    private(set) var name: String
    private(set) var color: String
    private(set) var price: Double

    init(name: String, color: String, price: Double) {
        self.name = name
        self.color = color
        self.price = price
    }
}
