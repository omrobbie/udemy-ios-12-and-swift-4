//
//  Location.swift
//  Threads
//
//  Created by omrobbie on 31/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
    @objc dynamic private(set) var latitude = 0.0
    @objc dynamic private(set) var longitude = 0.0

    convenience init(latitude: Double, longitude: Double) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
}
