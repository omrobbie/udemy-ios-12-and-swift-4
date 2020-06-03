//
//  ViewController.swift
//  RxNamer
//
//  Created by omrobbie on 03/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var lblHello: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var lblNames: UILabel!
    
    let disposeBage = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        txtName.rx.text.map {
            "Hello, \($0!)"
        }
        .bind(to: lblHello.rx.text)
        .disposed(by: disposeBage)
    }
}
