//
//  ViewController.swift
//  Screenie
//
//  Created by omrobbie on 22/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import ReplayKit

class ViewController: UIViewController {

    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var segPicker: UISegmentedControl!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var swtMic: UISwitch!
    @IBOutlet weak var btnRecord: UIButton!

    fileprivate var recorder = RPScreenRecorder.shared()
    fileprivate var isRecording = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    fileprivate func startRecording() {
        guard recorder.isAvailable else {
            debugPrint("Recording is not available at this time!")
            return
        }

        recorder.isMicrophoneEnabled = swtMic.isOn
        recorder.startRecording { (error) in
            if let error = error {
                debugPrint("Error: \(error.localizedDescription)")
                return
            }

            DispatchQueue.main.async {
                self.swtMic.isEnabled = false
                self.btnRecord.setTitle("Stop", for: .normal)
                self.btnRecord.setTitleColor(.systemRed, for: .normal)
                self.lblStatus.text = "Recording..."
                self.lblStatus.textColor = .systemRed
                self.isRecording = true
            }
        }
    }

    fileprivate func stopRecording() {
        self.swtMic.isEnabled = true
        self.btnRecord.setTitle("Record", for: .normal)
        self.btnRecord.setTitleColor(.systemGreen, for: .normal)
        self.lblStatus.text = "Ready to Record"
        self.lblStatus.textColor = .label
        self.isRecording = false
    }

    @IBAction func segPickerTapped(_ sender: UISegmentedControl) {
        var imgName = ""

        switch sender.selectedSegmentIndex {
        case 0: imgName = "skate"
        case 1: imgName = "food"
        case 2: imgName = "cat"
        case 3: imgName = "nature"
        default: break
        }

        imgSelected.image = UIImage(named: imgName)
    }

    @IBAction func btnRecord(_ sender: Any) {
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
    }
}
