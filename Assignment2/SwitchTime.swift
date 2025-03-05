//
//  SwitchTime.swift
//  Assignment2
//
//  Created by Trevor Hong on 2025-03-05.
//
import SceneKit
import SwiftUI

class SwitchTime {
    private var ambientLightNode = SCNNode()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        setupAmbientLight()
    }
    
    
    // Sets up the ambient light (if not already set up)
    func setupAmbientLight() {
        let ambientLight = SCNNode()
        ambientLight.light = SCNLight()
        ambientLight.light!.type = .ambient
        ambientLight.light!.color = UIColor.red
        ambientLight.light!.intensity = 5000
        ambientLightNode = ambientLight
    }
    
    func getLightNode() -> SCNNode {
        return ambientLightNode
    }
    
    // Toggles the visibility of the ambient light
}


