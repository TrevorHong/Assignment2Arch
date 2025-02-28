//
//  MazeCreation.swift
//  Assignment2
//
//  Created by Jiang Peng Han on 2025-02-27.
//

func testMaze(){
    let maze = Maze(rows: 5, cols: 5);
    maze.create();
    
    let cell = maze.getCell(row: 0, col: 0);
    print(cell.northWallPresent);
}
