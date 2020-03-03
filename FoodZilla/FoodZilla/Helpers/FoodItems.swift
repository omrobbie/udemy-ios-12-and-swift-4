//
//  FoodItems.swift
//  FoodZilla
//
//  Created by omrobbie on 03/03/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

let defaultPrice = 9.99

let salmon = Item(image: UIImage(named: "food1")!, name: "Salmon", price: defaultPrice)
let cheeseBurger = Item(image: UIImage(named: "food2")!, name: "Cheese Burger", price: defaultPrice)
let burrito = Item(image: UIImage(named: "food3")!, name: "Burrito", price: defaultPrice)
let spaghetti = Item(image: UIImage(named: "food4")!, name: "Spaghetti", price: defaultPrice)
let pizza = Item(image: UIImage(named: "food5")!, name: "Pizza", price: defaultPrice)
let salad = Item(image: UIImage(named: "food6")!, name: "Salad", price: defaultPrice)

let foodItems: [Item] = [
    salmon,
    cheeseBurger,
    burrito,
    spaghetti,
    pizza,
    salad
]
