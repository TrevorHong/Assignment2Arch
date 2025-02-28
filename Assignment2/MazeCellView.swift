//
//  MazeCellView.swift
//  Assignment2
//
//  Created by Jiang Peng Han on 2025-02-27.
//

import SwiftUI

struct MazeCellView: View {
    var cell: MazeCell
    
    var body: some View {
        ZStack {
            // Background color for the cell
            Color.white
                .frame(width: 40, height: 40)
                .border(Color.black, width: 1)
            
            // Draw walls based on the cell's wall data
            if cell.northWallPresent {
                Rectangle()
                    .frame(width: 40, height: 1)
                    .foregroundColor(.black)
                    .offset(y: -20)
            }
            if cell.southWallPresent {
                Rectangle()
                    .frame(width: 40, height: 1)
                    .foregroundColor(.black)
                    .offset(y: 20)
            }
            if cell.eastWallPresent {
                Rectangle()
                    .frame(width: 1, height: 40)
                    .foregroundColor(.black)
                    .offset(x: 20)
            }
            if cell.westWallPresent {
                Rectangle()
                    .frame(width: 1, height: 40)
                    .foregroundColor(.black)
                    .offset(x: -20)
            }
        }
    }
}
