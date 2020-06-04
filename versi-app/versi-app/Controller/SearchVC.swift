//
//  SearchVC.swift
//  versi-app
//
//  Created by omrobbie on 03/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class SearchVC: UIViewController {
    
    @IBOutlet weak var txtSearch: RoundedBorderTextField!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindElements()
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func bindElements() {
        let searchResultsObservable = txtSearch.rx.text
            .orEmpty
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .map {
                $0.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        }
        .flatMap { (query) -> Observable<[Repo]> in
            if query == "" {
                return Observable<[Repo]>.just([])
            } else {
                let url = searchUrl + query! + starsDecendingSegment
                var searchRepos = [Repo]()

                return URLSession.shared.rx.json(url: URL(string: url)!).map {
                    let results = $0 as AnyObject
                    let items = results.object(forKey: "items") as? [Dictionary<String, Any>] ?? []

                    for item in items {
                        let name = item["name"] as? String ?? ""
                        let description = item["description"] as? String ?? ""
                        let language = item["language"] as? String ?? ""
                        let forkCount = item["forks_count"] as? Int ?? 0
                        let repoUrl = item["html_url"] as? String ?? ""

                        let repo = Repo(image: UIImage(named: "searchIconLarge")!, name: name, description: description, numberOfForks: forkCount, language: language, numberOfContributors: 0, repoUrl: repoUrl)

                        searchRepos.append(repo)
                    }

                    return searchRepos
                }
            }
        }
        .observeOn(MainScheduler.instance)

        searchResultsObservable.bind(to: tableView.rx.items(cellIdentifier: "cell")) {
            (row, repo: Repo, cell: SearchCell) in
            cell.parseData(item: repo)
        }.disposed(by: disposeBag)
    }
}

extension SearchVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchCell else {return}
        print(cell.repoUrl)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
