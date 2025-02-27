// GridView.swift
// Modified to include animation for grid cells and rotation of the grid

import ComposableArchitecture
import GameOfLife
import SwiftUI
import Theming

public struct GridView: View {
    @Bindable var store: StoreOf<GridModel>
    @State private var cellOpacity: Double = 1.0 // State for animating cell opacity
    @State private var cellScale: CGFloat = 1.0 // State for animating cell scaling

    public init(store: StoreOf<GridModel>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            GeometryReader { outer in
                ZStack {
                    // Add rotation effect directly to GridLines
                    GridLines(
                        rows: store.grid.size.rows,
                        cols: store.grid.size.cols,
                        lineWidth: store.lineWidth,
                        rotationAngle: store.gridRotationAngle
                    )
                    .rotationEffect(Angle(degrees: store.gridRotationAngle)) // Apply rotation effect
                    .animation(.easeInOut(duration: 1.0), value: store.gridRotationAngle) // Smooth animation

                    // Apply scaling and opacity animations to GridCells
                    GridCells(
                        rows: store.grid.size.rows,
                        cols: store.grid.size.cols,
                        lineWidth: store.lineWidth,
                        inset: store.inset,
                        states: store.grid
                    )
                    .scaleEffect(cellScale) // Use scaling state
                    .opacity(cellOpacity) // Use opacity state
                    .onAppear {
                        // Start pulsing animation for opacity
                        withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                            cellOpacity = 0.5 // Pulse between full and half opacity
                        }
                        // Start pulsing animation for scaling
                        withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                            cellScale = 1.1 // Pulse between normal and scaled-up size
                        }
                    }
                    .clipped() // Clip the cells to stay within the gridlines
                }
            }
            .aspectRatio(1.0, contentMode: .fit)
            .padding(store.lineWidth / 2.0)
            .background(Color("gridBackground", bundle: Theming.bundle))
            .clipped() // Additional clipping at the outermost level
            .padding(4.0)
        }
    }
}
#Preview {
    let rows = 5
    let cols = 5
    let lineWidth = 16.0
    let inset = 8.0

    GridView(
        store: .init(
            initialState: .init(
                lineWidth: lineWidth,
                inset: inset,
                grid: .init(rows, cols, Grid.Initializers.random)
            ),
            reducer: GridModel.init
        )
    )
}


