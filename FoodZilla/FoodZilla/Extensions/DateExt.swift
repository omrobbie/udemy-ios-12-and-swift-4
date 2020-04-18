//
//  DateExt.swift
//  FoodZilla
//
//  Created by omrobbie on 18/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

extension Date {

    func isLessThan(_ date: Date) -> Bool {
        return timeIntervalSince(date) < date.timeIntervalSinceNow
    }
}
