//
//  DroppablePin.swift
//  pixel-city
//
//  Created by omrobbie on 27/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import MapKit

class DroppablePin: NSObject, MKAnnotation {

    dynamic var coordinate: CLLocationCoordinate2D
    var identifier: String

    init(coordinate: CLLocationCoordinate2D, identifier: String) {
        self.coordinate = coordinate
        self.identifier = identifier
        super.init()
    }
}
