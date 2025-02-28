//
//  Maze3View.swift
//  Assignment2
//
//  Created by Jiang Peng Han on 2025-02-27.
//

import SwiftUI
import SceneKit

struct Maze3View: UIViewRepresentable {
    var maze: Maze3
    
    init() {
        maze = Maze3(rows: 5, cols: 5) // Initialize with default 5x5 maze
        maze.create() // Generate the maze
    }
    
    // Create the SCNView
    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        
        // Set the scene for the SCNView
        scnView.scene = createScene()
        scnView.allowsCameraControl = true // Allow the user to control the camera
        
        // Set the background color of the scene
        scnView.backgroundColor = .white
        
        return scnView
    }
    
    // Update the SCNView if needed
    func updateUIView(_ uiView: SCNView, context: Context) {
        // Handle any updates if needed (currently not used)
    }
    
    // Create a SceneKit scene from the Maze
    func createScene() -> SCNScene {
        let scene = SCNScene()
        
        // Generate the maze nodes using the Maze object
        let mazeNode = maze.generateScene()
        scene.rootNode.addChildNode(mazeNode)
        
        // Add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(0, 5, 10) // Set camera position to view the maze
        scene.rootNode.addChildNode(cameraNode)
        
        // Add a light to the scene to illuminate the maze
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(0, 5, 5)
        scene.rootNode.addChildNode(lightNode)
        
        return scene
    }
}
