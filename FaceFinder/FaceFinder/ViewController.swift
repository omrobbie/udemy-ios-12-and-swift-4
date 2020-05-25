//
//  ViewController.swift
//  FaceFinder
//
//  Created by omrobbie on 25/05/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var lblMessage: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
    }

    func setupImageView() {
        guard let image = UIImage(named: "face") else {return}
        let scaleHeight = (view.frame.width / image.size.width) * image.size.height

        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scaleHeight)
        view.addSubview(imageView)
        spinner.startAnimating()
    }

    func performVisionRequest(for image: CGImage) {
        let faceDetectionRequest = VNDetectFaceRectanglesRequest { (request, error) in
            if let error = error {
                print("Failed to detect face: \(error.localizedDescription)")
                return
            }

            request.results?.forEach({ (result) in
                guard let faceObservation = result as? VNFaceObservation else {return}
                print("Bounding Box:\n", faceObservation.boundingBox)
            })
        }

        let imageRequestHandler = VNImageRequestHandler(cgImage: image, options: [:])
        do {
            try imageRequestHandler.perform([faceDetectionRequest])
        } catch {
            print("Failed to perform image request: \(error.localizedDescription)")
            return
        }
    }
}
