//
//  RampPickerVC.swift
//  ramp-up
//
//  Created by omrobbie on 26/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import SceneKit

enum RampScene: String, CaseIterable {
    case pipe
    case pyramid
    case quarter
}

class RampPickerVC: UIViewController {

    var sceneView: SCNView!
    var size: CGSize!

    let scene = SCNScene(named: "art.scnassets/ramps.scn")!

    init(size: CGSize) {
        super.init(nibName: nil, bundle: nil)
        self.size = size
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        setupCamera()
        addRampNode()
    }

    fileprivate func setupScene() {
        view.frame = CGRect(origin: CGPoint.zero, size: size)
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        view.insertSubview(sceneView, at: 0)
        sceneView.scene = scene
        preferredContentSize = size
    }

    fileprivate func setupCamera() {
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        scene.rootNode.camera = camera
    }

    fileprivate func addRampNode() {

        for scn in RampScene.allCases {
            let obj = SCNScene(named: "art.scnassets/\(scn.rawValue).dae")
            let node = obj?.rootNode.childNode(withName: scn.rawValue, recursively: true)!
            var scale, x, y, z: Float

            switch scn {
            case .pipe:
                scale = 0.0022
                x = 1.1; y = 0.5; z = -1
            case .pyramid:
                scale = 0.0072
                x = 1.1; y = -0.6; z = -1
            case .quarter:
                scale = 0.0082
                x = 1.1; y = -2.5; z = -1
            }

            let rotate = SCNAction.repeatForever(
                SCNAction.rotateBy(
                    x: 0,
                    y: CGFloat(0.01 * Double.pi),
                    z: 0,
                    duration: TimeInterval.random(in: 0.05..<0.1)
                )
            )

            node?.runAction(rotate)
            node?.scale = SCNVector3Make(scale, scale, scale)
            node?.position = SCNVector3Make(x, y, z)
            scene.rootNode.addChildNode(node!)
        }
    }
}
