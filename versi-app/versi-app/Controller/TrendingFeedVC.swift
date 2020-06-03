//
//  TrendingFeedVC.swift
//  versi-app
//
//  Created by omrobbie on 03/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class TrendingFeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var data: [Repo] = [
        Repo(image: #imageLiteral(resourceName: "searchIconLarge"), name: "Repo 1", description: "Deskripsi", numberOfForks: 1, language: "C", numberOfContributors: 1, repoUrl: "url"),
        Repo(image: #imageLiteral(resourceName: "searchIconLarge"), name: "Repo 2", description: "Deskripsi", numberOfForks: 1, language: "C", numberOfContributors: 1, repoUrl: "url"),
        Repo(image: #imageLiteral(resourceName: "searchIconLarge"), name: "Repo 3", description: "Deskripsi", numberOfForks: 1, language: "C", numberOfContributors: 1, repoUrl: "url"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        DownloadService.instance.downloadTrendingRepos { (data) in
            data.forEach {
                print($0.name)
            }
        }
    }
}

extension TrendingFeedVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TrendingRepoCell else {return UITableViewCell()}
        let item = data[indexPath.row]
        cell.parseData(item: item)
        return cell
    }
}
