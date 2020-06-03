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
    var namesArray: Variable<[String]> = Variable([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTextField()
        bindButton()
    }
    
    func bindTextField() {
        txtName.rx.text.map {
            if $0 == "" {
                return "Type your name below"
            } else {
                return "Hello, \($0!)"
            }
        }
        .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
        .bind(to: lblHello.rx.text)
        .disposed(by: disposeBage)
    }

    func bindButton() {
        btnSubmit.rx.tap.subscribe(onNext: {
            if self.txtName.text != "" {
                self.namesArray.value.append(self.txtName.text!)
                self.lblNames.rx.text.onNext(self.namesArray.value.joined(separator: ", "))
                self.txtName.rx.text.onNext("")
                self.lblHello.rx.text.onNext("Type your name below")
            }
        })
        .disposed(by: disposeBage)
    }
}
