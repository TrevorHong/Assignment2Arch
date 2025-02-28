//
//  MazeView.swift
//  Assignment2
//
//  Created by Jiang Peng Han on 2025-02-27.
//

import SwiftUI

struct MazeView: View {
    var maze: Maze
    
    var body: some View {
        let rows = maze.rows
        let cols = maze.cols
        var cells: [MazeCell] = []
        
        // Flatten the 2D maze into a 1D array of cells
        for row in 0..<rows {
            for col in 0..<cols {
                cells.append(maze.getCell(row: row, col: col))
            }
        }
        
        // Create a grid of maze cells
        let columns = Array(repeating: GridItem(.fixed(40)), count: cols)
        
        return LazyVGrid(columns: columns) {
            ForEach(0..<cells.count, id: \.self) { index in
                MazeCellView(cell: cells[index])
            }
        }
        .padding()
    }
}
