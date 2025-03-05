//
//  SceneViewWrapper.swift
//  Assignment2
//
//  Created by Trevor Hong on 2025-02-27.
//

import SceneKit
import SwiftUI

struct SceneViewWrapper: UIViewRepresentable {
    //    private let scene = SCNScene()
    private let flashlight = Flashlight()
    private let ambientLightNode = SCNNode()
    
    let mazeGenerator = GenerateMaze()
    
    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        //        scnView.scene = scene
        scnView.scene = mazeGenerator
        scnView.allowsCameraControl = false
        scnView.backgroundColor = UIColor.gray
        //        scnView.showsStatistics = true
        scnView.autoenablesDefaultLighting = true
        
        
        addCameraToScene()
        addFlashlightToScene()

        
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
    
    func addFlashlightToScene(){
        let flashlightNode = flashlight.getLightNode()
        mazeGenerator.rootNode.addChildNode(flashlightNode)
    }
}

