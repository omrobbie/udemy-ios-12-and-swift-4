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

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "cell")) { (row, repo: Repo, cell: TrendingRepoCell) in
            cell.parseData(item: repo)
        }.disposed(by: disposeBag)
    }

    func fetchData() {
        DownloadService.instance.downloadTrendingRepos { (trendingRepoArray) in
            self.dataSource.onNext(trendingRepoArray)
        }
    }
}
