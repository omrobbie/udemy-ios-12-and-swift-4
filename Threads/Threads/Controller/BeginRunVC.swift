//
//  FirstViewController.swift
//  Threads
//
//  Created by omrobbie on 30/01/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import MapKit

class BeginRunVC: LocationVC {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lastRunBgView: UIView!
    @IBOutlet weak var lastRunBtn: UIButton!
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        mapView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.startUpdatingLocation()
    }

    override func viewWillDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }

    @IBAction func locationCenterBtnPressed(_ sender: Any) {
    }

    @IBOutlet weak var lastRunBtnPressed: NSLayoutConstraint!
}

extension BeginRunVC: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
}
