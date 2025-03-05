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
        light.castsShadow = false
        light.color = UIColor.white
        light.intensity = 80000
        light.spotInnerAngle = 10
        light.spotOuterAngle = 30
        light.shadowColor = UIColor.black.withAlphaComponent(0.5)
        light.zFar = 20
        light.zNear = 0.1

        lightNode.light = light
        lightNode.position = SCNVector3(0, 5, 0)
        
        //Shines downward
        //Set SCNVector3 to (0, 0, 0) to shine forward
        lightNode.eulerAngles = SCNVector3(-Double.pi / 2, 0, 0)
        
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

//    @MainActor
//    func handleDrag(offset: CGSize) {
//        let deltaX = Float(offset.width) * 0.05
//        let deltaZ = Float(offset.height) * 0.05
//
//        lightNode.position.x += deltaX
//        lightNode.position.z -= deltaZ
//
//        print("Flashlight moved to \(lightNode.position)")
//    }
}
