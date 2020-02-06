//
//  DateToString.swift
//  RNDM
//
//  Created by omrobbie on 06/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

enum DateFormat: String {
    case shortDate = "dd/MM/yyyy"
    case shortDateTime = "MMM d, hh:mm"
}

extension Date {

    func toString(format: DateFormat = .shortDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}
