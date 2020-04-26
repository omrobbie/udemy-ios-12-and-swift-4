//
//  RampPickerVC.swift
//  ramp-up
//
//  Created by omrobbie on 26/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import SceneKit

class RampPickerVC: UIViewController {

    var sceneView: SCNView!
    var size: CGSize!

    init(size: CGSize) {
        super.init(nibName: nil, bundle: nil)
        self.size = size
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.frame = CGRect(origin: CGPoint.zero, size: size)
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        view.insertSubview(sceneView, at: 0)

        let scene = SCNScene(named: "art.scnassets/ramps.scn")!
        sceneView.scene = scene

        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        scene.rootNode.camera = camera

        let obj = SCNScene(named: "art.scnassets/pipe/pipe.dae")
        let node = obj?.rootNode.childNode(withName: "pipe", recursively: true)!
        let scale: Float = 0.0022
        node?.scale = SCNVector3Make(scale, scale, scale)
        node?.position = SCNVector3Make(1.1, 0.7, -1)
        scene.rootNode.addChildNode(node!)

        preferredContentSize = size
    }
}
