//
//  ContentView.swift
//  Assignment2
//
//  Created by Jiang Peng Han on 2025-02-27.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    
    var body: some View {
        VStack{
            Text("Maze Scene")
                .font(.title)
                .padding()
            let scene = GenerateMaze()
            SceneView(scene: scene, options: [.allowsCameraControl])
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    ContentView()
}
