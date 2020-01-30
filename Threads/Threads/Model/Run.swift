//
//  Run.swift
//  Threads
//
//  Created by omrobbie on 30/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation
import RealmSwift

class Run: Object {
    dynamic private(set) var id = ""
    dynamic private(set) var date = NSDate()
    dynamic private(set) var pace = 0
    dynamic private(set) var distance = 0.0
    dynamic private(set) var duration = 0

    override class func primaryKey() -> String? {
        return "id"
    }

    override class func indexedProperties() -> [String] {
        return ["pace", "date", "duration"]
    }

    convenience init(pace: Int, distance: Double, duration: Int) {
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.date = NSDate()
        self.pace = pace
        self.distance = distance
        self.duration = duration
    }

    static func addRunToRealm(pace: Int, distance: Double, duration: Int) {
        let run = Run(pace: pace, distance: distance, duration: duration)

        do {
            let realm = try Realm()

            try realm.write {
                realm.add(run)
                try realm.commitWrite()
            }
        } catch {
            debugPrint("Error adding run to Realm: \(error.localizedDescription)")
        }
    }
}
