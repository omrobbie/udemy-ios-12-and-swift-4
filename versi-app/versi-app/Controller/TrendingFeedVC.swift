//
//  TrendingFeedVC.swift
//  versi-app
//
//  Created by omrobbie on 03/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TrendingFeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let dataSource = PublishSubject<[Repo]>()
    let disposeBag = DisposeBag()

    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refreshControl
        refreshControl.tintColor = #colorLiteral(red: 0.2784313725, green: 0.5490196078, blue: 0.9019607843, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(
            string: "Fetching Hot GitHub Repos 🔥",
            attributes: [
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2784313725, green: 0.5490196078, blue: 0.9019607843, alpha: 1),
                NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 16.0)!
            ]
        )
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)

        fetchData()
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "cell")) { (row, repo: Repo, cell: TrendingRepoCell) in
            cell.parseData(item: repo)
        }.disposed(by: disposeBag)
    }

    @objc func fetchData() {
        DownloadService.instance.downloadTrendingRepos { (trendingRepoArray) in
            self.dataSource.onNext(trendingRepoArray)
            self.refreshControl.endRefreshing()
        }
    }
}
