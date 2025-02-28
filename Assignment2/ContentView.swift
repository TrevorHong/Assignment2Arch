//
//  ContentView.swift
//  Assignment2
//
//  Created by Jiang Peng Han on 2025-02-27.
//

import SwiftUI

struct ContentView: View {
    @State private var lastDragPosition: CGSize = .zero
    let sceneWrapper = SceneViewWrapper()

    var body: some View {
        ZStack {
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
        }
    }
}

#Preview {
    ContentView()
}
