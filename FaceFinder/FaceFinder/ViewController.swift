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
        guard let cgImage = image.cgImage else {
            print("Could not find CGImage")
            return
        }

        let scaleHeight = (view.frame.width / image.size.width) * image.size.height

        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scaleHeight)
        view.addSubview(imageView)

        spinner.startAnimating()

        DispatchQueue.global(qos: .background).async {
            self.performVisionRequest(for: cgImage, with: scaleHeight)
        }
    }

    func createFaceOutline(for rectangle: CGRect) {
        let yellowView = UIView()
        yellowView.backgroundColor = .clear
        yellowView.layer.borderColor = UIColor.yellow.cgColor
        yellowView.layer.borderWidth = 3
        yellowView.layer.cornerRadius = 5
        yellowView.alpha = 0.0
        yellowView.frame = rectangle
        view.addSubview(yellowView)

        UIView.animate(withDuration: 0.3) {
            yellowView.alpha = 0.75
            self.spinner.alpha = 0.0
            self.lblMessage.alpha = 0.0
        }
    }

    func performVisionRequest(for image: CGImage, with scaledHeight: CGFloat) {
        let faceDetectionRequest = VNDetectFaceRectanglesRequest { (request, error) in
            if let error = error {
                print("Failed to detect face: \(error.localizedDescription)")
                return
            }

            request.results?.forEach({ (result) in
                guard let faceObservation = result as? VNFaceObservation else {return}
                print("Bounding Box:\n", faceObservation.boundingBox)

                DispatchQueue.main.async {
                    let width = self.view.frame.width * faceObservation.boundingBox.width
                    let height = scaledHeight * faceObservation.boundingBox.height
                    let x = self.view.frame.width * faceObservation.boundingBox.origin.x
                    let y = scaledHeight * (1 - faceObservation.boundingBox.origin.y) - height
                    let faceRectangle = CGRect(x: x, y: y, width: width, height: height)

                    self.spinner.stopAnimating()
                    self.lblMessage.text = "Face found!"
                    self.createFaceOutline(for: faceRectangle)
                }
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
