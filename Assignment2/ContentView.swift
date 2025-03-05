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
                    .gesture(
                        TapGesture()
                            .onEnded {
                                sceneWrapper.handleTap()
                            }
                    )
                Button("Toggle Ambient Light") {
                    sceneWrapper.toggleAmbientLight()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }}
    
//    let scene = TestView()
//    var body: some View {
//        ZStack{
//            VStack{
//                scene
//                    .edgesIgnoringSafeArea(.all)  // Optional: To make the scene take up the full screen
//            }
//        }
//        }
}


#Preview {
    ContentView()
}
