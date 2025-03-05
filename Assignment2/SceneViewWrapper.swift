//
//  SceneViewWrapper.swift
//  Assignment2
//
//  Created by Trevor Hong on 2025-02-27.
//

import SceneKit
import SwiftUI
extension SCNVector3 {
    static func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3(left.x + right.x, left.y + right.y, left.z + right.z)
    }
}

struct SceneViewWrapper: UIViewRepresentable {
    //    private let scene = SCNScene()
    private let flashlight = Flashlight()
    private let ambientLightNode = SCNNode()
    private let addCube = AddCube()
    private let ambientLight = SwitchTime()
    
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
//        addFlashlightToScene()
        addCubeToScene()
        startCubeRotation()
        addAmbientLightToScene()
        
        scnView.debugOptions = [.showLightExtents, .showLightInfluences, .showPhysicsShapes]
        
        print("Scene initialized with flashlight and ground")
        return scnView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {}
    
//    func handleDrag(offset: CGSize) {
//        Task { @MainActor in
//            flashlight.handleDrag(offset: offset)
//        }
//    }
    


    
    func addCubeToScene() {
        if let cubeNode = addCube.rootNode.childNode(withName: "The Cube", recursively: true) {
            mazeGenerator.rootNode.addChildNode(cubeNode)
            print("Cube added to maze scene")
        } else {
            print("Cube node not found in AddCube scene")
        }
    }
    
    func addCameraToScene() {
        // Create and position a camera node
        let cameraNode = SCNNode()
        let camera = SCNCamera()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 5, y: 5, z: 5)  // Adjust the camera position
//        cameraNode.eulerAngles = SCNVector3(-Float.pi / 4, Float.pi / 4, 0)
        cameraNode.eulerAngles = SCNVector3(0, 0, 0)
        
        
        // Name the camera node for reference
        cameraNode.name = "cameraNode"
        
        // Add the camera node to the scene (maze's root node)
        mazeGenerator.rootNode.addChildNode(cameraNode)
        
        // Add the flashlight and attach it to the camera node
        addFlashlightToScene(cameraNode: cameraNode)
    }

    func addFlashlightToScene(cameraNode: SCNNode) {
        let flashlightNode = flashlight.getLightNode()
        
        // Add the flashlight as a child of the camera node
        cameraNode.addChildNode(flashlightNode)
        
        // Optionally, adjust the flashlight's position relative to the camera
        flashlightNode.position = SCNVector3(0, 0, -1)  // Adjust flashlight position in front of the camera
    }

    func startCubeRotation() {
        guard let cubeNode = mazeGenerator.rootNode.childNode(withName: "The Cube", recursively: true) else {
            print("Cube not found for rotation")
            return
        }
        
        let rotateAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat.pi / 4, z: 0, duration: 1.0))
        cubeNode.runAction(rotateAction)
    }
    
    func addAmbientLightToScene(){
        let ambientLight = ambientLight.getLightNode()
        mazeGenerator.rootNode.addChildNode(ambientLight)
    }
    
    func toggleAmbientLight() {
        ambientLightNode.isHidden.toggle()
    }
    func handleTap() {
        // Handle tap to move the camera forward based on its rotation (eulerAngles)
        print("Tap detected, moving the camera forward based on its rotation.")

        // Get the camera node
        guard let cameraNode = mazeGenerator.rootNode.childNode(withName: "cameraNode", recursively: true) else {
            print("Camera node not found")
            return
        }
        
        // Get the camera's eulerAngles (rotation in radians)
        let eulerAngles = cameraNode.eulerAngles
        
        // Calculate the forward direction based on the camera's yaw (y-axis) and pitch (x-axis)
        let forwardX = sin(Double(eulerAngles.y)) * cos(Double(eulerAngles.x))
        let forwardY = sin(Double(eulerAngles.x))
        let forwardZ = cos(Double(eulerAngles.y)) * cos(Double(eulerAngles.x))
        
        // Create a direction vector based on the camera's rotation
        let forward = SCNVector3(Float(forwardX), Float(forwardY), Float(forwardZ))
        
        // Define how far the camera should move when a tap is detected
        let moveDistance: Float = -1.0 // You can adjust this value for faster/slower movement
        
        // Move the camera forward along the forward vector
        let moveVector = SCNVector3(forward.x * moveDistance, forward.y * moveDistance, forward.z * moveDistance)
        print("move vector: \(moveVector)")
        
        // Update the camera's position by adding the move vector to its current position
        cameraNode.position = cameraNode.position + moveVector

        print("Camera moved to new position: \(cameraNode.position)")
    }


    
    func handleDrag(offset: CGSize) {
        // Get the current camera node
        guard let cameraNode = mazeGenerator.rootNode.childNode(withName: "cameraNode", recursively: true) else {
            print("Camera node not found")
            return
        }

        // Calculate the amount to rotate based on the drag offset
        let sensitivity: Float = 0.005 // Control the speed of the rotation

        // Update the camera's rotation based on the drag offset
        var newEulerAngles = cameraNode.eulerAngles

        // Modify the yaw (rotation around Y axis) and pitch (rotation around X axis)
        newEulerAngles.y += Float(offset.width) * sensitivity // Horizontal drag controls yaw (left-right rotation)
        newEulerAngles.x += Float(offset.height) * sensitivity // Vertical drag controls pitch (up-down rotation)

        // Clamping the pitch to prevent flipping the camera
        newEulerAngles.x = max(-Float.pi / 2, min(Float.pi / 2, newEulerAngles.x))

        // Apply the new rotation to the camera node
        cameraNode.eulerAngles = newEulerAngles

//        print("Camera rotated to: \(cameraNode.eulerAngles)")
    }
    
    
}

