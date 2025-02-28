//
//  ContentView.swift
//  Assignment2
//
//  Created by Jiang Peng Han on 2025-02-27.
//

import SwiftUI

struct ContentView: View {
    @State private var maze = Maze(rows: 5, cols: 5)
    @State private var maze2 = Maze2(rows: 5, cols: 5)
    @State private var maze3 = Maze3(rows: 5, cols: 5)
    
    
    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
        
        //2D
//        VStack {
//            Text("Maze")
//                .font(.title)
//                .padding()
//            
//            Button("Create Maze"){
//                maze.create()
//                let cell = maze.getCell(row: 0, col: 0)
//                print(cell.northWallPresent)
//            }
//            
//            MazeView(maze:maze)
//        }
        
//        VStack {
//            Text("3D Maze")
//                .font(.title)
//                .padding()
//            
//            Button("Create Maze") {
//                maze.create()  // Generate the maze
//            }
//            .padding()
//            
//            // Show the 3D Maze
//            MazeSceneView(maze: maze2)
//                .frame(width: 300, height: 300)
//        }
        
        VStack {
            // Embed the MazeView in ContentView
            Maze3View()
                .edgesIgnoringSafeArea(.all) // Make the maze fill the screen
                .frame(height: 400) // You can adjust this height as needed
        }
}
}

#Preview {
    ContentView()
}
