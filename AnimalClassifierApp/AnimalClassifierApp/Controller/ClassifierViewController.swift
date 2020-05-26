//
//  ClassifierViewController.swift
//  AnimalClassifierApp
//
//  Created by omrobbie on 26/05/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ClassifierViewController: UIViewController {

    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var lblClassification: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
}
