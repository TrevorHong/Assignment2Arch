//
//  ContentView.swift
//  Assignment2
//
//  Created by Jiang Peng Han on 2025-02-27.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    @State private var lastDragPosition: CGSize = .zero
    @State private var isNightMode: Bool = true 
    let sceneWrapper = SceneViewWrapper()

    var body: some View {
        ZStack {
            VStack {
                sceneWrapper
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let offset = CGSize(
                                    width: value.translation.width - lastDragPosition.width,
                                    height: value.translation.height - lastDragPosition.height
                                )
                                sceneWrapper.handleDrag(offset: offset)
                                lastDragPosition = value.translation
                            }
                            .onEnded { _ in
                                lastDragPosition = .zero
                            }
                    )

                Button(action: {
                }) {
                    Text("Switch Time")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
          
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
