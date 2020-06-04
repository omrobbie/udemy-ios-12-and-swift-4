//
//  DownloadService.swift
//  versi-app
//
//  Created by omrobbie on 03/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class DownloadService {

    static let instance = DownloadService()

    func downlaodTrendingReposDictArray(completion: @escaping (_ reposDictArray: [Dictionary<String, Any>]) -> ()) {
        var trendingRepoArray = [Dictionary<String, Any>]()
        Alamofire.request(trendingRepoUrl).responseJSON { (response) in
            guard let json = response.result.value as? Dictionary<String, Any> else {return}
            guard let repoDictionaryArray = json["items"] as? [Dictionary<String, Any>] else {return}

            for repoDict in repoDictionaryArray {
                if trendingRepoArray.count < 10 {
                    guard let avatarUrl = repoDict["avatar_url"] as? String,
                        let name = repoDict["name"] as? String,
                        let description = repoDict["description"] as? String,
                        let numberOfForks = repoDict["forks_count"] as? Int,
                        let language = repoDict["language"] as? String,
                        let contributorsUrl = repoDict["contributors_url"] as? String,
                        let ownerDict = repoDict["owner"] as? Dictionary<String, Any>,
                        let repoUrl = repoDict["html_url"] as? String
                        else {
                            break
                    }

                    let repoDictionary: Dictionary<String, Any> = [
                        "avatarUrl": avatarUrl,
                        "name": name,
                        "description": description,
                        "numberOfForks": numberOfForks,
                        "language": language,
                        "contributorsUrl": contributorsUrl,
                        "ownerDict": ownerDict,
                        "repoUrl": repoUrl,
                    ]

                    trendingRepoArray.append(repoDictionary)
                } else {
                    break
                }
            }

            completion(trendingRepoArray)
        }
    }

    func downloadTrendingRepos(completion: @escaping (_ repoArray: [Repo]) -> ()) {
        var reposArray = [Repo]()
        downlaodTrendingReposDictArray { (trendingRepoDictArray) in
            for dict in trendingRepoDictArray {
                self.downloadTrendingRepo(fromDictionary: dict) { (repo) in
                    if reposArray.count < 10 {
                        reposArray.append(repo)
                    } else {
                        let sortedArray = reposArray.sorted { (repoA, repoB) -> Bool in
                            if repoA.numberOfForks > repoB.numberOfForks {
                                return true
                            } else {
                                return false
                            }
                        }
                        completion(sortedArray)
                    }
                }
            }
        }
    }

    func downloadTrendingRepo(fromDictionary dict: Dictionary<String, Any>, completion: @escaping (_ repo: Repo) -> ()) {
        let avatarUrl = dict["avatar_url"] as! String
        let contributorsUrl = dict["contributorsUrl"] as! String
        let name = dict["name"] as! String
        let description = dict["description"] as! String
        let numberOfForks = dict["forks_count"] as! Int
        let language = dict["language"] as! String
        let repoUrl = dict["html_url"] as! String

        downloadImageFor(avatarUrl: avatarUrl) { (returnedImage) in
            self.downloadContributorsDataFor(contributorsUrl: contributorsUrl) { (returnedContributions) in
                let repo = Repo(image: returnedImage, name: name, description: description, numberOfForks: numberOfForks, language: language, numberOfContributors: returnedContributions, repoUrl: repoUrl)

                completion(repo)
            }
        }
    }

    func downloadImageFor(avatarUrl: String, completion: @escaping (_ image: UIImage) -> ()) {
        Alamofire.request(avatarUrl).responseImage { (imageResponse) in
            guard let image = imageResponse.result.value else {return}
            completion(image)
        }
    }

    func downloadContributorsDataFor(contributorsUrl: String, completion: @escaping (_ contributors: Int) -> ()) {
        Alamofire.request(contributorsUrl).responseJSON { (response) in
            guard let json = response.result.value as? [Dictionary<String, Any>] else {return}

            if !json.isEmpty {
                let contributors = json.count
                completion(contributors)
            }
        }
    }
}
