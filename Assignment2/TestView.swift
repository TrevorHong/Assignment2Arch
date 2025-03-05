//
//  TestView.swift
//  Assignment2
//
//  Created by Jiang Peng Han on 2025-03-04.
//

import SceneKit
import SwiftUI

struct TestView: UIViewRepresentable {
    var mazeGenerator = GenerateMaze()

    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()

        // Set up the scene with maze generator
        scnView.scene = mazeGenerator
        scnView.allowsCameraControl = true
        scnView.backgroundColor = UIColor.gray
        scnView.showsStatistics = true
        scnView.autoenablesDefaultLighting = true
        
        // Add camera and lighting to the scene
        addCameraToScene()
        
        // Debug options
        scnView.debugOptions = [.showLightExtents, .showLightInfluences, .showPhysicsShapes]

        return scnView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {}

    // Add camera node
    func addCameraToScene() {
        let cameraNode = SCNNode()
        let camera = SCNCamera()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 5, y: 5, z: 5)  // Adjust camera position
        cameraNode.eulerAngles = SCNVector3(-Float.pi/4, Float.pi/4, 0)

        mazeGenerator.rootNode.addChildNode(cameraNode)
    }
}
