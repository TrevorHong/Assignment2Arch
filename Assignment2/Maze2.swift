//
//  Maze2.swift
//  Assignment2
//
//  Created by Jiang Peng Han on 2025-02-27.
//

import SceneKit
import SwiftUI

class Maze2 {
    var rows: Int
    var cols: Int
    var mazeCells: [[MazeCell]]
    
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        self.mazeCells = Array(repeating: Array(repeating: MazeCell(northWallPresent: true, southWallPresent: true, eastWallPresent: true, westWallPresent: true), count: cols), count: rows)
    }
    
    func create() {
        // Example of creating a random maze
        for r in 0..<rows {
            for c in 0..<cols {
                mazeCells[r][c].northWallPresent = true
                mazeCells[r][c].southWallPresent = true
                mazeCells[r][c].eastWallPresent = true
                mazeCells[r][c].westWallPresent = true
            }
        }
        
        // Simple random generation example, this should be replaced with actual maze creation logic
        mazeCells[0][0].northWallPresent = false  // Entrance
        mazeCells[rows-1][cols-1].southWallPresent = false  // Exit
    }
    
    // Generate SceneKit walls for each cell in the maze
    func generateScene() -> SCNNode {
        let mazeNode = SCNNode()
        
        let wallHeight: CGFloat = 1.0
        let wallThickness: CGFloat = 0.1
        let spacing: CGFloat = 2.0
        
        for r in 0..<rows {
            for c in 0..<cols {
                let cell = mazeCells[r][c]
                
                if cell.northWallPresent {
                    let wallNode = createWallNode()
                    wallNode.position = SCNVector3(x: Float(c) * Float(spacing), y: Float(wallHeight/2), z: Float(r) * Float(spacing) + Float(spacing)/2)
                    mazeNode.addChildNode(wallNode)
                }
                
                if cell.southWallPresent {
                    let wallNode = createWallNode()
                    wallNode.position = SCNVector3(x: Float(c) * Float(spacing), y: Float(wallHeight/2), z: Float(r) * Float(spacing) - Float(spacing)/2)
                    mazeNode.addChildNode(wallNode)
                }
                
                if cell.eastWallPresent {
                    let wallNode = createWallNode()
                    wallNode.position = SCNVector3(x: Float(c) * Float(spacing) + Float(spacing)/2, y: Float(wallHeight/2), z: Float(r) * Float(spacing))
                    wallNode.rotation = SCNVector4(0, 1, 0, Float.pi/2)
                    mazeNode.addChildNode(wallNode)
                }
                
                if cell.westWallPresent {
                    let wallNode = createWallNode()
                    wallNode.position = SCNVector3(x: Float(c) * Float(spacing) - Float(spacing)/2, y: Float(wallHeight/2), z: Float(r) * Float(spacing))
                    wallNode.rotation = SCNVector4(0, 1, 0, -Float.pi/2)
                    mazeNode.addChildNode(wallNode)
                }
            }
        }
        
        return mazeNode
    }
    
    private func createWallNode() -> SCNNode {
        let wallGeometry = SCNBox(width: 1.0, height: 1.0, length: 0.1, chamferRadius: 0.0)
        let wallMaterial = SCNMaterial()
        wallMaterial.diffuse.contents = UIColor.gray
        wallGeometry.materials = [wallMaterial]
        let wallNode = SCNNode(geometry: wallGeometry)
        return wallNode
    }
}
