//
//  MazeCell.swift
//  Assignment2
//
//  Created by Jiang Peng Han on 2025-03-04.
//

class MazeCell {
    var northWallPresent: Bool
    var southWallPresent: Bool
    var eastWallPresent: Bool
    var westWallPresent: Bool

    init(northWallPresent: Bool, southWallPresent: Bool, eastWallPresent: Bool, westWallPresent: Bool) {
        self.northWallPresent = northWallPresent
        self.southWallPresent = southWallPresent
        self.eastWallPresent = eastWallPresent
        self.westWallPresent = westWallPresent
    }
}

enum Direction: Int {
    case north = 0, east, south, west
}
