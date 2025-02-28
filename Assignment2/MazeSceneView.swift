//
//  MazeSceneView.swift
//  Assignment2
//
//  Created by Jiang Peng Han on 2025-02-27.
//

import SwiftUI
import SceneKit

struct MazeSceneView: UIViewRepresentable {
    var maze: Maze2
    
    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        scnView.scene = SCNScene()  // Start with an empty scene
        scnView.allowsCameraControl = true  // Allow user to control the camera
        
        // Add the 3D maze scene to the SCNView
        let mazeNode = maze.generateScene()
        scnView.scene?.rootNode.addChildNode(mazeNode)
        
        // Set up lighting for the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(0, 5, 10)
        scnView.scene?.rootNode.addChildNode(lightNode)
        
        return scnView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        // Optionally update the view when the maze changes
    }
}
