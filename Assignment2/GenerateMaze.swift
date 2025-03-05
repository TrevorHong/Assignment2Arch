//
//  GenerateMaze.swift
//  Assignment2
//
//  Created by Jiang Peng Han on 2025-03-04.
//

import SceneKit
import SwiftUI

class GenerateMaze: SCNScene {
    var cameraNode = SCNNode()
    var rows = 5
    var cols = 5
//    var mazeCells: [[MazeCell]]
    private var mazeSet: DisjointSet
    private var maze: [[MazeCell]]

    override init() {
        self.mazeSet = DisjointSet(setSize: rows * cols)
//        self.maze = Array(repeating: Array(repeating: MazeCell(northWallPresent: true, southWallPresent: true, eastWallPresent: true, westWallPresent: true), count: cols), count: rows)
        self.maze = []
        for _ in 0..<rows {
            var row: [MazeCell] = []
            for _ in 0..<cols {
                row.append(MazeCell(northWallPresent: true, southWallPresent: true, eastWallPresent: true, westWallPresent: true))
            }
            self.maze.append(row)
        }

        
        super.init()
        
//        background.contents = UIColor.black
        
        createMaze()
        setupMaze()
//        setupCamera()

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func setupCamera() {
        let camera = SCNCamera() // Create Camera object
        cameraNode.camera = camera // Give the cameraNode a camera
        cameraNode.position = SCNVector3(5, 5, 5) // Set the position to (5, 5, 5)
        cameraNode.eulerAngles = SCNVector3(-Float.pi/4, Float.pi/4, 0) // Set the pitch, yaw, and roll
        rootNode.addChildNode(cameraNode) // Add the cameraNode to the scene
    }
    
    func createMaze() {
        maze[0][0].northWallPresent = false
        maze[rows - 1][cols - 1].southWallPresent = false
        var entrySet = mazeSet.find(x: 0)
        var exitSet = mazeSet.find(x: (rows * cols) - 1)
        
        print("Generating maze walls...")
        while entrySet != exitSet {
            let randRow = Int.random(in: 0..<rows)
            let randCol = Int.random(in: 0..<cols)
            let wall = Direction(rawValue: Int.random(in: 0..<4))!
            var s1 = 0, s2 = 0
            
            switch wall {
            case .north:
                if randRow > 0 {
                    s1 = mazeSet.find(x: cols * randRow + randCol)
                    s2 = mazeSet.find(x: cols * (randRow - 1) + randCol)
                    if s1 != s2 {
                        maze[randRow][randCol].northWallPresent = false
                        maze[randRow - 1][randCol].southWallPresent = false
                        mazeSet.unionSets(s1: s1, s2: s2)
                        print("Removing north wall at (\(randRow), \(randCol)) and south wall at (\(randRow - 1), \(randCol))")
                    }
                    
                }
            case .south:
                if randRow < (rows - 1) {
                    s1 = mazeSet.find(x: cols * randRow + randCol)
                    s2 = mazeSet.find(x: cols * (randRow + 1) + randCol)
                    if s1 != s2 {
                        maze[randRow][randCol].southWallPresent = false
                        maze[randRow + 1][randCol].northWallPresent = false
                        mazeSet.unionSets(s1: s1, s2: s2)
                        print("Removing south wall at (\(randRow), \(randCol)) and north wall at (\(randRow + 1), \(randCol))")
                    }
                
                }
            case .east:
                if randCol < (cols - 1) {
                    s1 = mazeSet.find(x: cols * randRow + randCol)
                    s2 = mazeSet.find(x: cols * randRow + randCol + 1)
                    if s1 != s2 {
                        maze[randRow][randCol].eastWallPresent = false
                        maze[randRow][randCol + 1].westWallPresent = false
                        mazeSet.unionSets(s1: s1, s2: s2)
                        print("Removing east wall at (\(randRow), \(randCol)) and west wall at (\(randRow), \(randCol + 1))")
                    }
                }
            case .west:
                if randCol > 0 {
                    s1 = mazeSet.find(x: cols * randRow + randCol)
                    s2 = mazeSet.find(x: cols * randRow + randCol - 1)
                    if s1 != s2 {
                        maze[randRow][randCol].westWallPresent = false
                        maze[randRow][randCol - 1].eastWallPresent = false
                        mazeSet.unionSets(s1: s1, s2: s2)
                        print("Removing west wall at (\(randRow), \(randCol)) and east wall at (\(randRow), \(randCol - 1))")
                    }
                }
            }
            
            entrySet = mazeSet.find(x: 0)
            exitSet = mazeSet.find(x: (rows * cols) - 1)
        }
        print("Maze Generation Complete")
    }

    // Generate SceneKit maze using cubes with disabled sides
    //Used to be -> SCNNode
    func setupMaze() {
//        let scene = SCNScene()
        
        let mazeNode = SCNNode()
        let wallThickness: CGFloat = 0.01
        let cellSize: CGFloat = 1.0

        addFloorTexture(mazeNode: mazeNode, cellSize: cellSize, rows: rows, cols: cols)
        
        for row in 0..<rows {
            for col in 0..<cols {
//                let cell = mazeCells[r][c]
                let cell = maze[row][col]
                let x = CGFloat(col) * cellSize
                let z = CGFloat(row) * cellSize
                
//                print("Wall positions: x=\(x), z=\(z)") // Debug the positions of walls
                
                
                
                if cell.northWallPresent {
                    let northWall = createWall(width: cellSize, height: cellSize, thickness: wallThickness, imageName: "crate.jpg")
                    northWall.position = SCNVector3(x, 0, (z - cellSize / 2) + wallThickness)
                    mazeNode.addChildNode(northWall)
//                    print("North wall present")
                }
                if cell.southWallPresent {
                    let southWall = createWall(width: cellSize, height: cellSize, thickness: wallThickness, imageName: "night.jpg")
                    southWall.position = SCNVector3(x, 0, (z + cellSize / 2) - wallThickness)
                    mazeNode.addChildNode(southWall)
//                    print("South wall present")
                }
                if cell.eastWallPresent {
                    let eastWall = createWall(width: wallThickness, height: cellSize, thickness: cellSize, imageName: "pink.jpeg")
                    eastWall.position = SCNVector3((x + cellSize / 2) - wallThickness, 0, z)
                    mazeNode.addChildNode(eastWall)
//                    print("East wall present")
                }
                if cell.westWallPresent {
                    let westWall = createWall(width: wallThickness, height: cellSize, thickness: cellSize, imageName: "sunset.jpg")
                    westWall.position = SCNVector3((x - cellSize / 2) + wallThickness, 0, z)
                    mazeNode.addChildNode(westWall)
//                    print("West wall present")
                }
            }
        }
        rootNode.addChildNode(mazeNode)
//        return scene
    }
    
    func addFloorTexture(mazeNode: SCNNode, cellSize: CGFloat, rows: Int, cols: Int) {
        let floorWidth = CGFloat(cols) * cellSize
        let floorHeight = CGFloat(rows) * cellSize
        let floor = SCNPlane(width: floorWidth, height:floorHeight)
        
        let floorMaterial = SCNMaterial()
        floorMaterial.diffuse.contents = UIImage(named: "grass.jpg")
        floorMaterial.isDoubleSided = true;
        
        
        floor.materials = [floorMaterial]
        
        let floorNode = SCNNode(geometry: floor)
        
        let floorX = Float(CGFloat(cols - 1) * cellSize / 2)  // Half the width of the maze
        let floorZ = Float(CGFloat(rows - 1) * cellSize / 2)
        
        floorNode.rotation = SCNVector4(1, 0, 0, Double.pi / 2)
        floorNode.position = SCNVector3(x:floorX, y:-0.5, z:floorZ)
        
        mazeNode.addChildNode(floorNode)
        
    }
    
    func createWall(width: CGFloat, height: CGFloat, thickness: CGFloat, imageName: String) -> SCNNode {
        let wall = SCNBox(width: width, height: height, length: thickness, chamferRadius: 0.0)
        let material = SCNMaterial()
//        material.diffuse.contents = color  // Wall color
        material.diffuse.contents = UIImage(named: imageName)
        wall.materials = [material]
        
        let wallNode = SCNNode(geometry: wall)
        return wallNode
    }
}
