//
//  DoubleExt.swift
//  LegDay
//
//  Created by omrobbie on 19/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

extension Double {

    func convertToClockTime() -> String {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60

        return String(format: "%0d:%02d", arguments: [minutes, seconds])
    }
}
