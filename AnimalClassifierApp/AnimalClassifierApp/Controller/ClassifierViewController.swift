//
//  ClassifierViewController.swift
//  AnimalClassifierApp
//
//  Created by omrobbie on 26/05/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ClassifierViewController: UIViewController {

    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var lblClassification: UILabel!

    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: AnimalClassifier().model)
            let request = VNCoreMLRequest(model: model) { (request, error) in
                if let error = error {
                    print("Error: \(error)")
                }

                self.processClassifications(for: request, error: error)
            }

            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load vision ML model: \(error)")
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let classifications = request.results as? [VNClassificationObservation] else {
                self.lblClassification.text = "Unable to classify image.\n\(error?.localizedDescription ?? "Error")"
                return
            }

            if classifications.isEmpty {
                self.lblClassification.text = "Nothing recognized!"
            } else {
                let topClassification = classifications.prefix(2)
                let descriptions = topClassification.map { (classification) in
                    return String(format: "%.2f", classification.confidence * 100) + "% - " + classification.identifier
                }

                self.lblClassification.text = "Classifications:\n" + descriptions.joined(separator: "\n")
            }
        }
    }

    func updateClassification(for image: UIImage) {
        lblClassification.text = "Classifying..."

        guard let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue)),
            let ciImage = CIImage(image: image) else {
                displayError()
                return
        }

        DispatchQueue.global(qos: .userInteractive).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)

            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }

    func displayError() {
        lblClassification.text = "Something went wrong, please try again!"
    }

    @IBAction func btnCameraTapped(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("You don't have a camera!")
            presentPhotoPicker(sourceType: .photoLibrary)
            return
        }

        let photoSourcePicker = UIAlertController()

        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { (_) in
            self.presentPhotoPicker(sourceType: .camera)
        }

        let choosePhotoAction = UIAlertAction(title: "Choose Photo", style: .default) { (_) in
            self.presentPhotoPicker(sourceType: .photoLibrary)
        }

        photoSourcePicker.addAction(takePhotoAction)
        photoSourcePicker.addAction(choosePhotoAction)
        photoSourcePicker.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(photoSourcePicker, animated: true)
    }

    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }
}

extension ClassifierViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("No image selected!")
        }

        imgSelected.image = image
        updateClassification(for: image)
    }
}
