//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by omrobbie on 29/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController {

    @IBOutlet weak var pointsTextField: UITextField!
    @IBOutlet weak var createGoalBtn: UIButton!

    var goalDescription: String!
    var goalType: GoalType!

    override func viewDidLoad() {
        super.viewDidLoad()
        pointsTextField.inputAccessoryView = createGoalBtn
    }

    func initData(description: String, type: GoalType) {
        goalDescription = description
        goalType = type
    }

    func save(completion: @escaping (_ finished: Bool) -> ()) {
        guard let manageContext = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: manageContext)

        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)

        do {
            try manageContext.save()
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
    }

    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        if pointsTextField.text != "" {
            save { (complete) in
                if complete {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func backBtnWasPressed(_ yusender: Any) {
        dismissDetail()
    }
}
