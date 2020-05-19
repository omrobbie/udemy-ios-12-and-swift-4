//
//  CameraVC.swift
//  vision-app-dev
//
//  Created by omrobbie on 18/05/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import AVFoundation

class CameraVC: UIViewController {

    @IBOutlet weak var imgCaptured: RoundedShadowImageView!
    @IBOutlet weak var btnFlash: RoundedShadowButton!
    @IBOutlet weak var lblIdentification: UILabel!
    @IBOutlet weak var lblConfidence: UILabel!
    @IBOutlet weak var viewCamera: UIView!

    var captureSession: AVCaptureSession!
    var cameraOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let previewLayer = previewLayer else {return}
        previewLayer.frame = viewCamera.bounds
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
                captureSession.startRunning()
            }
        } catch {
            debugPrint("Error: \(error.localizedDescription)")
        }
    }
}
