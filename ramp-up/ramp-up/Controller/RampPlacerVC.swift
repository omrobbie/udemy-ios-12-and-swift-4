//
//  RampPlacerVC.swift
//  ramp-up
//
//  Created by omrobbie on 26/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class RampPlacerVC: UIViewController, ARSCNViewDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = SCNScene(named: "art.scnassets/pipe/pipe.dae")!
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }

    func onRampSelected(_ rampName: String) {
        print(rampName)
    }

    @IBAction func btnAddTapped(_ sender: UIButton) {
        let vc = RampPickerVC(size: CGSize(width: 250, height: 500))
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.delegate = self
        vc.rampPlacerVC = self
        present(vc, animated: true)
        vc.popoverPresentationController?.sourceView = sender
        vc.popoverPresentationController?.sourceRect = sender.bounds
    }
}
