//
//  ViewController.swift
//  Scribe
//
//  Created by omrobbie on 19/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var txtTranscribe: UITextView!
    @IBOutlet weak var activityRecord: UIActivityIndicatorView!

    fileprivate var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    fileprivate func requestSpeechAuth() {
        activityRecord.startAnimating()
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        sound.play()
                    } catch {
                        debugPrint("Error: \(error.localizedDescription)")
                    }

                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
                        if let error = error {
                            debugPrint("Error: \(error.localizedDescription)")
                            return
                        }

                        if let result = result {
                            print(result.bestTranscription.formattedString)
                        }
                    })
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(message: "File  not found!")
                        self.activityRecord.stopAnimating()
                    }
                }
            }
        }
    }

    fileprivate func showAlert(message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default)
        alertVC.addAction(actionOk)
        present(alertVC, animated: true)
    }

    @IBAction func btnRecordTapped(_ sender: Any) {
        requestSpeechAuth()
    }
}
