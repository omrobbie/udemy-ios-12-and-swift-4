//
//  DownloadService.swift
//  versi-app
//
//  Created by omrobbie on 03/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation
import Alamofire

class DownloadService {

    static let instance = DownloadService()

    func downlaodTrendingRepoDictArray(completion: @escaping (_ reposDictArray: [Dictionary<String, Any>]) -> ()) {
        var trendingRepoArray = [Dictionary<String, Any>]()
        Alamofire.request(trendingRepoUrl).responseJSON { (response) in
            guard let json = response.result.value as? Dictionary<String, Any> else {return}
            guard let repoDictionary = json["items"] as? [Dictionary<String, Any>] else {return}
            print(repoDictionary)
        }
    }
}
