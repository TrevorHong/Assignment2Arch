//
//  AddCube.swift
//  Assignment2
//
//  Created by Trevor Hong on 2025-03-05.
//
import SceneKit

class AddCube: SCNScene {
    var rotAngle = 0.0
    var isRotating = true
    var cameraNode = SCNNode()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        
        background.contents = UIColor.black
        
        setupCamera()
        addCube()
        Task(priority: .userInitiated) {
            await firstUpdate()
        }
    }
    
    func setupCamera() {
        let camera = SCNCamera()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(5, 5, 5)
        cameraNode.eulerAngles = SCNVector3(-Float.pi/4, Float.pi/4, 0)
        rootNode.addChildNode(cameraNode)
    }
    
    func addCube() {
        let theCube = SCNNode(geometry: SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0))
        theCube.name = "The Cube"
        theCube.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "crate.jpg")
        theCube.position = SCNVector3(0, 0, 0)
        rootNode.addChildNode(theCube)
    }
    
    @MainActor
    func firstUpdate() {
        reanimate()
    }
    
    @MainActor
    func reanimate() {
        let theCube = rootNode.childNode(withName: "The Cube", recursively: true)
        if (isRotating) {
            rotAngle += 0.0005
            if rotAngle > Double.pi {
                rotAngle -= Double.pi
            }
        }
        theCube?.eulerAngles = SCNVector3(0, rotAngle, 0)
        Task { try! await Task.sleep(nanoseconds: 10000)
            reanimate()
        }
    }
}
