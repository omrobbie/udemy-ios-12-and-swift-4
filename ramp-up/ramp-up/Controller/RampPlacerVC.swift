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
    @IBOutlet weak var controls: UIStackView!
    @IBOutlet weak var btnRotate: UIButton!
    @IBOutlet weak var btnUp: UIButton!
    @IBOutlet weak var btnDown: UIButton!

    var selectedRamp: String?
    var selectedNode : SCNNode?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizer()
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

    fileprivate func setupGestureRecognizer() {
        let gesture1 = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        let gesture2 = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        let gesture3 = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))

        gesture1.minimumPressDuration = 0.1
        gesture2.minimumPressDuration = 0.1
        gesture3.minimumPressDuration = 0.1

        btnRotate.addGestureRecognizer(gesture1)
        btnUp.addGestureRecognizer(gesture2)
        btnDown.addGestureRecognizer(gesture3)
    }

    fileprivate func placeRamp(position: SCNVector3) {
        guard let rampName = selectedRamp else {return}
        let scene = SCNScene(named: "art.scnassets/\(rampName).dae")!
        let node = scene.rootNode.childNode(withName: rampName, recursively: true)!
        node.position = position
        selectedNode = node
        sceneView.scene.rootNode.addChildNode(node)
        controls.isHidden = false
    }

    @objc fileprivate func handleLongPress(_ gestureRecognizer: UIGestureRecognizer) {
        if let node = selectedNode {
            switch gestureRecognizer.state {
            case .ended: node.removeAllActions()
            case .began:
                switch gestureRecognizer.view {
                case btnRotate:
                    let rotate = SCNAction.repeatForever(
                        SCNAction.rotateBy(x: 0, y: CGFloat(0.08 * Double.pi), z: 0, duration: 0.1)
                    )
                    node.runAction(rotate)
                case btnUp:
                    let moveUp = SCNAction.repeatForever(
                        SCNAction.moveBy(x: 0, y: 0.08, z: 0, duration: 0.1)
                    )
                    node.runAction(moveUp)
                case btnDown:
                    let moveDown = SCNAction.repeatForever(
                        SCNAction.moveBy(x: 0, y: -0.08, z: 0, duration: 0.1)
                    )
                    node.runAction(moveDown)
                default: break
                }
            default: break
            }
        }
    }

    @IBAction func btnAddTapped(_ sender: UIButton) {
        let vc = RampPickerVC(size: CGSize(width: 250, height: 500))
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.delegate = self
        vc.rampPlacerVC = self
        present(vc, animated: true)
        vc.popoverPresentationController?.sourceView = sender
        vc.popoverPresentationController?.sourceRect = sender.bounds
        controls.isHidden = true
    }

    @IBAction func btnRemoveTapped(_ sender: Any) {
        if let node = selectedNode {
            node.removeFromParentNode()
        }
    }
}
