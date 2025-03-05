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
    
    let mazeGenerator = GenerateMaze()

    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
//        scnView.scene = scene
        scnView.scene = mazeGenerator
        scnView.allowsCameraControl = true
//        scnView.backgroundColor = UIColor.gray
        scnView.showsStatistics = true
        scnView.autoenablesDefaultLighting = true

//        let ground = SCNNode(geometry: SCNPlane(width: 50, height: 200))
//        let groundMaterial = SCNMaterial()
//        groundMaterial.diffuse.contents = UIColor.gray
//        ground.geometry?.materials = [groundMaterial]
//
//        ground.rotation = SCNVector4(1, 0, 0, -Float.pi / 2)
//        ground.position = SCNVector3(0, 0, 0)
//        scene.rootNode.addChildNode(ground)

        let flashlightNode = flashlight.getLightNode()
        scene.rootNode.addChildNode(flashlightNode)

        addCameraToScene()
        if let cameraNode = mazeGenerator.rootNode.childNode(withName: "cameraNode", recursively: false) {
            print("Camera node added to the scene at position: \(cameraNode.position)")
        }
        
        //Add maze
        scene.rootNode.addChildNode(mazeGenerator.rootNode)
        
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
    
    func addCameraToScene() {
            // Create and position a camera node
            let cameraNode = SCNNode()
            let camera = SCNCamera()
            cameraNode.camera = camera
            cameraNode.position = SCNVector3(x: 5, y: 5, z: 5)  // Adjust the camera position
            cameraNode.eulerAngles = SCNVector3(-Float.pi/4, Float.pi/4, 0)
            
            // Name the camera node for reference
            cameraNode.name = "cameraNode"
            mazeGenerator.rootNode.addChildNode(cameraNode)
        }
}

