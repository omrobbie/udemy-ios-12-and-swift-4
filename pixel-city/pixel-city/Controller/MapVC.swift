//
//  ViewController.swift
//  pixel-city
//
//  Created by omrobbie on 27/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        locationManager.delegate = self
        configureLocationService()
    }

    @IBAction func centerBtnTapped(_ sender: Any) {
    }
}

extension MapVC: MKMapViewDelegate {

}

extension MapVC: CLLocationManagerDelegate {
    func configureLocationService() {
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
}
