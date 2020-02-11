//
//  CommentsVC.swift
//  RNDM
//
//  Created by omrobbie on 08/02/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Firebase

class CommentsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCommentTxt: UITextField!
    @IBOutlet var keyboardView: UIView!

    var thought: Thought!
    var thoughtRef: DocumentReference!
    var username: String!
    var commentListener: ListenerRegistration!

    var comments = [Comment]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        thoughtRef = Firestore.firestore().collection(THOUGHTS_REF).document(thought.documentId)

        if let name = Auth.auth().currentUser?.displayName {
            username = name
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        commentListener = thoughtRef.collection(COMMENTS_REF)
            .order(by: TIMESTAMP)
            .addSnapshotListener({ (snapshot, error) in
                if let error = error {
                    debugPrint("Error fetching comment: \(error.localizedDescription)")
                    return
                }

                self.comments = Comment.parseData(snapshot: snapshot)
                self.tableView.reloadData()

                if self.comments.count > 0 {
                    let indexPath = IndexPath(row: self.comments.count - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .none, animated: true)
                }
            })
    }

    override func viewDidDisappear(_ animated: Bool) {
        commentListener.remove()
    }

    @IBAction func addCommentBtnTapped(_ sender: Any) {
        guard let comment = addCommentTxt.text else {return}

        Firestore.firestore().runTransaction({ (transaction, error) -> Any? in
            let thoughtDocument: DocumentSnapshot

            do {
                try thoughtDocument = transaction.getDocument(self.thoughtRef)
            } catch {
                debugPrint("Error add comment: \(error.localizedDescription)")
                return nil
            }

            guard let oldNumComment = thoughtDocument.data()?[NUM_COMMENTS] as? Int else {return nil}

            transaction.updateData([NUM_COMMENTS: oldNumComment + 1], forDocument: self.thoughtRef)

            let newCommentRef = self.thoughtRef.collection(COMMENTS_REF).document()

            transaction.setData([
                COMMENT: comment,
                TIMESTAMP: FieldValue.serverTimestamp(),
                USERNAME: self.username ?? "",
                USER_ID: Auth.auth().currentUser?.uid ?? ""
            ], forDocument: newCommentRef)

            return nil
        }) { (object, error) in
            if let error = error {
                debugPrint("Error add comment transaction: \(error.localizedDescription)")
                return
            }

            self.addCommentTxt.text = ""
        }
    }
}

extension CommentsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as? CommentCell else {return UITableViewCell()}

        cell.configureCell(comment: comments[indexPath.row], delegate: self)

        return cell
    }
}

extension CommentsVC: CommentDelegate {

    func commentOptionsTapped(comment: Comment) {
        print(comment.username ?? "")
    }
}
