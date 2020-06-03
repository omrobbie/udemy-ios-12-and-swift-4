//
//  AddNameViewController.swift
//  RxNamer
//
//  Created by omrobbie on 03/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddNameViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!

    let disposeBag = DisposeBag()
    let nameSubject = PublishSubject<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
