//
//  Constants.swift
//  pixel-city
//
//  Created by omrobbie on 28/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

let apiKey = "91858b6f536a990e55ac59fa41e48dbc"

func flickrUrl(forApiKey key: String, withAnnotation annotation: DroppablePin, andNumberOfPhotos number: Int) -> String {
    let url = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(key)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=mi&per_page=\(number)&format=json&nojsoncallback=1"
    return url
}
