//
//  ViewController.swift
//  Screenie
//
//  Created by omrobbie on 22/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import ReplayKit

class ViewController: UIViewController, RPPreviewViewControllerDelegate {

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
        recorder.stopRecording { (preview, error) in
            if let error = error {
                debugPrint("Error: \(error.localizedDescription)")
                return
            }

            guard preview != nil else {
                debugPrint("Preview is not available!")
                return
            }

            let alertVC = UIAlertController(title: "Recording Finished!", message: "Would yo like to edit or delete your recording?", preferredStyle: .alert)
            let actionDelete = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                self.recorder.discardRecording {
                    debugPrint("Recording successfully deleted!")
                }
            }
            let actionEdit = UIAlertAction(title: "Edit", style: .default) { (_) in
                preview!.previewControllerDelegate = self
                self.present(preview!, animated: true)
            }

            alertVC.addAction(actionDelete)
            alertVC.addAction(actionEdit)

            alertVC.modalPresentationStyle = .fullScreen
            self.present(alertVC, animated: true)

            self.swtMic.isEnabled = true
            self.btnRecord.setTitle("Record", for: .normal)
            self.btnRecord.setTitleColor(.systemGreen, for: .normal)
            self.lblStatus.text = "Ready to Record"
            self.lblStatus.textColor = .label
            self.isRecording = false
        }
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
