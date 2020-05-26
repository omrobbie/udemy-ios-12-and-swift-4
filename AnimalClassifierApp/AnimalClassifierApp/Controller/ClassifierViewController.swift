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
            return
        }

        let photoSourcePicker = UIAlertController()

        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { (_) in

        }

        let choosePhotoAction = UIAlertAction(title: "Choose Photo", style: .default) { (_) in

        }

        photoSourcePicker.addAction(takePhotoAction)
        photoSourcePicker.addAction(choosePhotoAction)
        photoSourcePicker.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(photoSourcePicker, animated: true)
    }
}
