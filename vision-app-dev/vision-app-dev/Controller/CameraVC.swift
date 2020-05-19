//
//  CameraVC.swift
//  vision-app-dev
//
//  Created by omrobbie on 18/05/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import AVFoundation
import CoreML
import Vision

class CameraVC: UIViewController {

    @IBOutlet weak var imgCaptured: RoundedShadowImageView!
    @IBOutlet weak var btnFlash: RoundedShadowButton!
    @IBOutlet weak var lblIdentification: UILabel!
    @IBOutlet weak var lblConfidence: UILabel!
    @IBOutlet weak var viewCamera: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    var captureSession: AVCaptureSession!
    var cameraOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var flashControlState: AVCaptureDevice.FlashMode = .off
    var speechSynthesizer = AVSpeechSynthesizer()

    var photoData: Data?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let previewLayer = previewLayer else {return}
        previewLayer.frame = viewCamera.bounds
        speechSynthesizer.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCameraView))
        tap.numberOfTouchesRequired = 1

        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080

        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("You don't have camera!")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }

            cameraOutput = AVCapturePhotoOutput()
            if captureSession.canAddOutput(cameraOutput) {
                captureSession.addOutput(cameraOutput)

                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
                previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait

                viewCamera.layer.addSublayer(previewLayer)
                viewCamera.addGestureRecognizer(tap)
                captureSession.startRunning()
            }
        } catch {
            debugPrint("Error: \(error.localizedDescription)")
        }
    }

    func resultMethod(request: VNRequest, error: Error?) {
        guard let result = request.results as? [VNClassificationObservation] else {return}

        for classification in result {
            if classification.confidence < 0.5 {
                let unknownObjectMessage = "I'm not sure what this is. Please try again!"
                lblIdentification.text = unknownObjectMessage
                lblConfidence.text = ""
                synthesizeSpeech(fromString: unknownObjectMessage)
                break
            } else {
                let identificationMessage = classification.identifier
                let confidenceLevel = Int(classification.confidence * 100)
                lblIdentification.text = identificationMessage
                lblConfidence.text = "CONFIDENCE: \(confidenceLevel)%"
                let completeSentence = "This looks like a \(identificationMessage) and I'm \(confidenceLevel) percent sure!"
                synthesizeSpeech(fromString: completeSentence)
                break
            }
        }

    }

    func synthesizeSpeech(fromString string: String) {
        let speechUtterance = AVSpeechUtterance(string: string)
        speechSynthesizer.speak(speechUtterance)
    }

    @objc func didTapCameraView(sender: UITapGestureRecognizer) {
        viewCamera.isUserInteractionEnabled = false
        spinner.startAnimating()

        let settings = AVCapturePhotoSettings()

        settings.previewPhotoFormat = settings.embeddedThumbnailPhotoFormat
        settings.flashMode = flashControlState
        cameraOutput.capturePhoto(with: settings, delegate: self)
    }

    @IBAction func btnFlashTapped(_ sender: Any) {
        if flashControlState == .off {
            btnFlash.setTitle("FLASH ON", for: .normal)
            flashControlState = .on
        } else {
            btnFlash.setTitle("FLASH OFF", for: .normal)
            flashControlState = .off
        }
    }
}

extension CameraVC: AVCapturePhotoCaptureDelegate {

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            debugPrint("Error: \(error.localizedDescription)")
        } else {
            photoData = photo.fileDataRepresentation()

            do {
                let model = try VNCoreMLModel(for: SqueezeNet().model)
                let request = VNCoreMLRequest(model: model, completionHandler: resultMethod)
                let handler = VNImageRequestHandler(data: photoData!)

                try handler.perform([request])
            } catch {
                debugPrint("Error: \(error.localizedDescription)")
            }

            imgCaptured.image = UIImage(data: photoData!)
        }
    }
}

extension CameraVC: AVSpeechSynthesizerDelegate {

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        viewCamera.isUserInteractionEnabled = true
        spinner.stopAnimating()
    }
}
