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

    var selectedRamp: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = true
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let result = sceneView.hitTest(touch.location(in: sceneView), types: [.featurePoint])
        guard let hitFeature = result.last else {return}
        let hitTransform = SCNMatrix4(hitFeature.worldTransform)
        let hitPosition = SCNVector3(hitTransform.m41, hitTransform.m42, hitTransform.m43)
        placeRamp(position: hitPosition)
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }

    func onRampSelected(_ rampName: String) {
        selectedRamp = rampName
    }

    fileprivate func placeRamp(position: SCNVector3) {
        guard let rampName = selectedRamp else {return}
        let scene = SCNScene(named: "art.scnassets/\(rampName).dae")!
        let node = scene.rootNode.childNode(withName: rampName, recursively: true)!
        node.position = position
        sceneView.scene.rootNode.addChildNode(node)
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
