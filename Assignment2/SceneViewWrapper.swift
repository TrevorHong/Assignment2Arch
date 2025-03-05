//
//  SceneViewWrapper.swift
//  Assignment2
//
//  Created by Trevor Hong on 2025-02-27.
//

import SceneKit
import SwiftUI

struct SceneViewWrapper: UIViewRepresentable {
    private let scene = SCNScene()
    private let flashlight = Flashlight()
    private let ambientLightNode = SCNNode()

    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        scnView.scene = scene
        scnView.allowsCameraControl = false
        scnView.backgroundColor = UIColor.gray
        scnView.showsStatistics = true
        scnView.autoenablesDefaultLighting = true

        let ground = SCNNode(geometry: SCNPlane(width: 50, height: 200))
        let groundMaterial = SCNMaterial()
        groundMaterial.diffuse.contents = UIColor.gray
        ground.geometry?.materials = [groundMaterial]

        ground.rotation = SCNVector4(1, 0, 0, -Float.pi / 2)
        ground.position = SCNVector3(0, 0, 0)
        scene.rootNode.addChildNode(ground)

        let flashlightNode = flashlight.getLightNode()
        scene.rootNode.addChildNode(flashlightNode)

        scnView.debugOptions = [.showLightExtents, .showLightInfluences, .showPhysicsShapes]

        print("Scene initialized with flashlight and ground")
        return scnView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {}

    func handleDrag(offset: CGSize) {
        Task { @MainActor in
            flashlight.handleDrag(offset: offset)
        }
    }
}

