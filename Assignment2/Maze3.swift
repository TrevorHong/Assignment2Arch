//
//  Maze3.swift
//  Assignment2
//
//  Created by Jiang Peng Han on 2025-02-27.
//

import SceneKit

class Maze3 {
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

    // Generate SceneKit maze using cubes with disabled sides
    func generateScene() -> SCNNode {
        let mazeNode = SCNNode()
        let wallHeight: CGFloat = 1.0
        let spacing: CGFloat = 1.0

        for r in 0..<rows {
            for c in 0..<cols {
                let cell = mazeCells[r][c]
                
                let wallNode = createCubeNode()
                wallNode.position = SCNVector3(x: Float(c) * Float(spacing), y: Float(wallHeight/2), z: Float(r) * Float(spacing))
                
                var nextMaterial: SCNMaterial
                
                nextMaterial = SCNMaterial()
                nextMaterial.diffuse.contents = UIColor.clear
                wallNode.geometry?.insertMaterial(nextMaterial, at: 4)

                // Hide the sides based on the wall properties
                if !cell.northWallPresent {
                    wallNode.geometry?.firstMaterial?.diffuse.contents = UIColor.clear  // Make the north wall invisible
                }
                if !cell.southWallPresent {
                    wallNode.geometry?.firstMaterial?.diffuse.contents = UIColor.clear  // Make the south wall invisible
                }
                if !cell.eastWallPresent {
                    wallNode.geometry?.firstMaterial?.diffuse.contents = UIColor.clear  // Make the east wall invisible
                }
                if !cell.westWallPresent {
                    wallNode.geometry?.firstMaterial?.diffuse.contents = UIColor.clear  // Make the west wall invisible
                }

                mazeNode.addChildNode(wallNode)
            }
        }

        return mazeNode
    }

    private func createCubeNode() -> SCNNode {
        let geometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        
        // Create a material for each side of the box
        let northMaterial = SCNMaterial()
        northMaterial.diffuse.contents = UIColor.gray

        let southMaterial = SCNMaterial()
        southMaterial.diffuse.contents = UIColor.gray

        let eastMaterial = SCNMaterial()
        eastMaterial.diffuse.contents = UIColor.gray

        let westMaterial = SCNMaterial()
        westMaterial.diffuse.contents = UIColor.gray

        // Assign the materials to the box sides
        geometry.materials = [northMaterial, southMaterial, eastMaterial, westMaterial]

        let cubeNode = SCNNode(geometry: geometry)
        return cubeNode
    }
}
