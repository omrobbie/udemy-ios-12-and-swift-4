//
//  BinaryDecimal.swift
//  Binary
//
//  Created by omrobbie on 30/05/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

class BinaryDecimal {

    var bits: [Int]?
    var integer: Int?

    init(_ bits: [Int]) {
        self.bits = bits
    }

    init(_ decimal: Int) {
        self.integer = decimal
    }

    func calculateBinaryValueForInt() -> String {
        let rows = [128, 64, 32, 16, 8, 4, 2, 1]
        var binaryRows: [Int] = []
        var newInt = integer!

        rows.forEach {
            let binaryDigit = oneOrZero(forValue: newInt, withBitValue: $0)
            binaryRows.append(binaryDigit)
            if binaryDigit == 1 {newInt = newInt - $0}
        }

        let stringFromIntArray = binaryRows.map{String($0)}
        return stringFromIntArray.joined()
    }

    func oneOrZero(forValue value: Int, withBitValue bitValue: Int) -> Int {
        return value - bitValue >= 0 ? 1 : 0
    }
}
