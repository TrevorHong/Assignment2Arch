//
//  Maze.swift
//  Assignment2
//
//  Created by Jiang Peng Han on 2025-02-27.
//

struct MazeCell {
    var northWallPresent: Bool
    var southWallPresent: Bool
    var eastWallPresent: Bool
    var westWallPresent: Bool
}

enum Direction: Int {
    case north = 0, east, south, west
}

class Maze {
    
    var rows: Int
    var cols: Int
    private var mazeSet: DisjointSet
    private var maze: [[MazeCell]]
    
    init(rows: Int = 4, cols: Int = 4) {
        self.rows = rows
        self.cols = cols
        self.mazeSet = DisjointSet(setSize: rows * cols)
        self.maze = Array(repeating: Array(repeating: MazeCell(northWallPresent: true, southWallPresent: true, eastWallPresent: true, westWallPresent: true), count: cols), count: rows)
    }
    
    func create() {
        maze[0][0].northWallPresent = false
        maze[rows - 1][cols - 1].southWallPresent = false
        var entrySet = mazeSet.find(x: 0)
        var exitSet = mazeSet.find(x: (rows * cols) - 1)
        
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
                    }
                }
            }
            
            entrySet = mazeSet.find(x: 0)
            exitSet = mazeSet.find(x: (rows * cols) - 1)
        }
    }
    
    func getCell(row: Int, col: Int) -> MazeCell {
        return maze[row][col]
    }
}
