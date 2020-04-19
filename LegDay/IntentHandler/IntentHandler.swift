//
//  IntentHandler.swift
//  IntentHandler
//
//  Created by omrobbie on 19/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Intents

class IntentHandler: INExtension, INStartWorkoutIntentHandling {

    func handle(intent: INStartWorkoutIntent, completion: @escaping (INStartWorkoutIntentResponse) -> Void) {
        print("Start workout intent: ", intent)

        guard let spokenPhrase = intent.workoutName?.spokenPhrase else {
            completion(INStartWorkoutIntentResponse(code: .failureNoMatchingWorkout, userActivity: nil))
            return
        }

        let userActivity: NSUserActivity? = nil

        if spokenPhrase == "walk" || spokenPhrase == "run" {
            completion(INStartWorkoutIntentResponse(code: .handleInApp, userActivity: userActivity))
        } else {
            completion(INStartWorkoutIntentResponse(code: .failureNoMatchingWorkout, userActivity: nil))
        }
    }
}
