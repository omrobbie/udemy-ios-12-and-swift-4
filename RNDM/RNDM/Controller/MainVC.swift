//
//  ViewController.swift
//  RNDM
//
//  Created by omrobbie on 05/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Firebase

enum ThoughtCategory: String {
    case funny = "funny"
    case serious = "serious"
    case crazy = "crazy"
    case popular = "popular"
}

class MainVC: UIViewController {

    @IBOutlet private weak var categorySegment: Ios12SegmentedControl!
    @IBOutlet private weak var tableView: UITableView!

    private var thoughts = [Thought]()
    private var thoughtsCollectionRef: CollectionReference!
    private var thoughtsListener: ListenerRegistration!
    private var selectedCategory: String = ThoughtCategory.funny.rawValue

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        thoughtsCollectionRef = Firestore.firestore().collection(THOUGHTS_REF)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setListener()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        thoughtsListener.remove()
    }

    func setListener() {
        thoughtsListener = thoughtsCollectionRef.whereField(CATEGORY, isEqualTo: selectedCategory).addSnapshotListener { (snapshot, error) in
            if let error = error {
                debugPrint("Error fetching documents: \(error.localizedDescription)")
            } else {
                guard let snapshot = snapshot else {return}
                self.thoughts.removeAll()

                for document in snapshot.documents {
                    let data = document.data()
                    let documentId = document.documentID

                    let category = data[CATEGORY] as? String ?? ""
                    let numComments = data[NUM_COMMENTS] as? Int ?? 0
                    let numLikes = data[NUM_LIKES] as? Int ?? 0
                    let thoughtTxt = data[THOUGHT_TXT] as? String ?? ""
                    let timestamp = data[TIMESTAMP] as? Date ?? Date()
                    let username = data[USERNAME] as? String ?? "Anonymous"

                    let newThought = Thought(documentId: documentId, category: category, numComments: numComments, numLikes: numLikes, thoughtTxt: thoughtTxt, timestamp: timestamp, username: username)

                    self.thoughts.append(newThought)
                }

                self.tableView.reloadData()
            }
        }
    }

    @IBAction func categoryChanged(_ sender: Any) {
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1:
            selectedCategory = ThoughtCategory.serious.rawValue
        case 2:
            selectedCategory = ThoughtCategory.crazy.rawValue
        default:
            selectedCategory = ThoughtCategory.popular.rawValue
        }

        thoughtsListener.remove()
        setListener()
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thoughts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "thoughtCell") as? ThoughtCell else {return UITableViewCell()}
        cell.configureCell(thought: thoughts[indexPath.row])

        return cell
    }
}
