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
    @IBOutlet weak var lastRunStackView: UIStackView!
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
        getLastRun()
    }

    override func viewWillDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }

    func getLastRun() {
        guard let lastRun = Run.getAllRuns()?.first else {
            lastRunBgView.isHidden = true
            lastRunStackView.isHidden = true
            lastRunBtn.isHidden = true
            return
        }

        lastRunBgView.isHidden = false
        lastRunStackView.isHidden = false
        lastRunBtn.isHidden = false

        paceLbl.text = lastRun.pace.formatTimeDurationToString()
        distanceLbl.text = "\(lastRun.distance.metersToMiles(places: 2)) mi"
        durationLbl.text = lastRun.duration.formatTimeDurationToString()
    }

    @IBAction func locationCenterBtnPressed(_ sender: Any) {
    }

    @IBAction func lastRunBtnPressed(_ sender: Any) {
        lastRunBgView.isHidden = true
        lastRunStackView.isHidden = true
        lastRunBtn.isHidden = true
    }
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
