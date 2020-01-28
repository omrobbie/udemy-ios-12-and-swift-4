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
import Alamofire
import AlamofireImage

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pullUpView: UIView!
    @IBOutlet weak var pullUpViewHeightConstraint: NSLayoutConstraint!

    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 1000

    var screenSize = UIScreen.main.bounds

    var spinner: UIActivityIndicatorView?
    var progressLbl: UILabel?

    var flowLayout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView?

    var imageUrlArray = [String]()
    var imageArray = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        locationManager.delegate = self
        configureLocationService()
        addDoubleTap()

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")
        collectionView?.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)

        collectionView?.delegate = self
        collectionView?.dataSource = self

        pullUpView.addSubview(collectionView!)
    }

    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin(sender:)))

        doubleTap.delegate = self
        doubleTap.numberOfTapsRequired = 2
        mapView.addGestureRecognizer(doubleTap)
    }

    func addSwipe() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(animateViewDown))

        swipe.direction = .down
        pullUpView.addGestureRecognizer(swipe)
    }

    func animateViewUp() {
        pullUpViewHeightConstraint.constant = 300
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func animateViewDown() {
        cancelAllSessions()

        pullUpViewHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    func addSpinner() {
        spinner = UIActivityIndicatorView(style: .large)
        spinner?.center = CGPoint(x: (screenSize.width / 2) + ((spinner?.frame.width)! / 2) - 10, y: 150)
        spinner?.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        spinner?.startAnimating()
        collectionView?.addSubview(spinner!)
    }

    func removeSpinner() {
        if spinner != nil {
            spinner?.removeFromSuperview()
        }
    }

    func addProgressLbl() {
        progressLbl = UILabel()
        progressLbl?.frame = CGRect(x: (screenSize.width / 2) - 150, y: 175, width: 300, height: 40)
        progressLbl?.font = UIFont(name: "Avenir Next", size: 18)
        progressLbl?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        progressLbl?.textAlignment = .center
        progressLbl?.text = "LOADING"
        collectionView?.addSubview(progressLbl!)
    }

    func removeProgressLbl() {
        if progressLbl != nil {
            progressLbl?.removeFromSuperview()
        }
    }

    @IBAction func centerBtnTapped(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
    }
}

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {return nil}
        
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")

        pinAnnotation.pinTintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        pinAnnotation.animatesDrop = true

        return pinAnnotation
    }

    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)

        mapView.setRegion(coordinateRegion, animated: true)
    }

    @objc func dropPin(sender: UITapGestureRecognizer) {
        removePin()
        removeSpinner()
        removeProgressLbl()
        cancelAllSessions()

        animateViewUp()
        addSwipe()
        addSpinner()
        addProgressLbl()

        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)

        let annotation = DroppablePin(coordinate: touchCoordinate, identifier: "droppablePin")
        mapView.addAnnotation(annotation)

        let coordinateRegion = MKCoordinateRegion(center: touchCoordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)

        retrieveUrls(forAnnotation: annotation) { (finished) in
            if finished {
                self.retrieveImages { (finished) in
                    if finished {
                        self.removeSpinner()
                        self.removeProgressLbl()
                    }
                }
            }
        }
    }

    func removePin() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }

    func retrieveUrls(forAnnotation annotation: DroppablePin, handler: @escaping (_ status: Bool) -> ()) {
        imageUrlArray = []

        Alamofire.request(flickrUrl(forApiKey: apiKey, withAnnotation: annotation, andNumberOfPhotos: 40)).responseJSON { (response) in
            guard let json = response.result.value as? Dictionary<String, AnyObject> else {return}
            let photosDict = json["photos"] as! Dictionary<String, AnyObject>
            let photosDictArray = photosDict["photo"] as! [Dictionary<String, AnyObject>]

            for photo in photosDictArray {
                let postUrl = "https://live.staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_d.jpg"
                self.imageUrlArray.append(postUrl)
            }
            handler(true)
        }
    }

    func retrieveImages(handler: @escaping (_ status: Bool) -> ()) {
        imageArray = []

        for url in imageUrlArray {
            Alamofire.request(url).responseImage { (response) in
                guard let image = response.result.value else {return}

                self.imageArray.append(image)
                self.progressLbl?.text = "\(self.imageArray.count)/40 IMAGES DOWNLOADED"

                if self.imageArray.count == self.imageUrlArray.count {
                    handler(true)
                }
            }
        }
    }

    func cancelAllSessions() {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach({ $0.cancel() })
            downloadData.forEach({ $0.cancel() })
        }
    }
}

extension MapVC: CLLocationManagerDelegate {
    func configureLocationService() {
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
}

extension MapVC: UIGestureRecognizerDelegate {

}

extension MapVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell

        return cell!
    }
}
