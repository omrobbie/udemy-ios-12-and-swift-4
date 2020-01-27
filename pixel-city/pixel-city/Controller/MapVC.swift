//
//  ViewController.swift
//  pixel-city
//
//  Created by omrobbie on 27/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }

    @IBAction func centerBtnTapped(_ sender: Any) {
    }
}

extension MapVC: MKMapViewDelegate {

}
