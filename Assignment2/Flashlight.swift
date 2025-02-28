//
//  Assignment2Tests.swift
//  Assignment2Tests
//
//  Created by Trevor Hong on 2025-02-27.
//

import SceneKit

class Flashlight {
    private let lightNode = SCNNode()

    init() {
        setupFlashlight()
    }

    private func setupFlashlight() {
        let light = SCNLight()
        light.type = .spot
        light.castsShadow = false  // No shadows needed
        light.color = UIColor.white
        light.intensity = 80000  // Bright but focused
        light.spotInnerAngle = 2  // 🔄 Make the inner circle small
        light.spotOuterAngle = 5  // 🔄 Make the outer beam small
        light.shadowColor = UIColor.black.withAlphaComponent(0.5)
        light.zFar = 20  // ✅ Prevents the light from spreading too far
        light.zNear = 0.1

        lightNode.light = light
        lightNode.position = SCNVector3(0, 5, 0)  // ✅ Start in front of the camera
        lightNode.eulerAngles = SCNVector3(0, 0, 0)  // ✅ Keep horizontal
        
        let sphere = SCNSphere(radius: 0.2)
        sphere.firstMaterial?.diffuse.contents = UIColor.red
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = lightNode.position
        lightNode.addChildNode(sphereNode)

        print("Flashlight initialized at \(lightNode.position)")
    }

    func getLightNode() -> SCNNode {
        return lightNode
    }

    @MainActor
    func handleDrag(offset: CGSize) {
        let deltaX = Float(offset.width) * 0.05
        let deltaZ = Float(offset.height) * 0.05

        lightNode.position.x += deltaX
        lightNode.position.z -= deltaZ

        print("Flashlight moved to \(lightNode.position)")
    }
}
