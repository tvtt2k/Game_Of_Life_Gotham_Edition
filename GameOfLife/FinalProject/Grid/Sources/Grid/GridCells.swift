//
//  GridCells.swift
//  Lecture16
//
//  Created by Van Simmons on 10/26/23.
//

import ComposableArchitecture
import GameOfLife
import SwiftUI
import Theming

extension GameOfLife.CellState {
    var imageName: String? {
        switch self {
            case .alive: return "AliveImage" // Replace with your image name
            case .born: return "BornImage" // Replace with your image name
            case .died: return "DiedImage" // Replace with your image name
            case .empty: return nil // No image for empty cells
        }
    }
}

struct GridCells: View {
    let rows: Int
    let cols: Int
    let lineWidth: Double
    let inset: Double
    let states: GameOfLife.Grid

    init(
        rows: Int,
        cols: Int,
        lineWidth: Double,
        inset: Double,
        states: GameOfLife.Grid
    ) {
        self.rows = rows
        self.cols = cols
        self.lineWidth = lineWidth
        self.inset = inset
        self.states = states
    }

    func row(for index: Int) -> Int { index / cols }

    func col(for index: Int) -> Int { index % cols }

    func size(for geo: GeometryProxy) -> CGSize {
        .init(
            width: geo.size.width / Double(cols) - lineWidth - inset,
            height: geo.size.height / Double(rows) - lineWidth - inset
        )
    }

    func image(for index: Int) -> String? {
        states[row(for: index), col(for: index)].imageName
    }

    func cellState(for index: Int) -> CellState {
        states[row(for: index), col(for: index)]
    }

    func baseCell(
        for geo: GeometryProxy,
        index: Int
    ) -> some View {
        let size = size(for: geo)
        if let imageName = image(for: index) {
            return AnyView(
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        width: size.width,
                        height: size.height
                    )
                    .offset(originOffset(for: index, in: geo))
                    .offset(standardInset)
            )
        } else {
            return AnyView(EmptyView()) // No rendering for empty cells
        }
    }

    func shadowedCell(
        for geo: GeometryProxy,
        index: Int
    ) -> some View {
        if cellState(for: index) == .empty {
            return AnyView(EmptyView()) // No shadow for empty cells
        } else {
            return AnyView(
                baseCell(for: geo, index: index)
                    .shadow(
                        color: .black,
                        radius: inset / 2,
                        x: inset,
                        y: inset
                    )
                    .shadow(
                        color: .black,
                        radius: inset / 2,
                        x: -inset / 2,
                        y: -inset / 2
                    )
            )
        }
    }

    func originOffset(for index: Int, in geo: GeometryProxy) -> CGSize {
        .init(
            width: Double(index % cols) * (geo.size.width / Double(cols)),
            height: Double(index / cols) * (geo.size.height / Double(rows))
        )
    }

    var standardInset: CGSize {
        .init(
            width: lineWidth / 2.0 + inset / 2.0,
            height: lineWidth / 2.0 + inset / 2.0
        )
    }

    var body: some View {
        GeometryReader { geo in
            ForEach(0 ..< (rows * cols), id: \.self) { currentCell in
                baseCell(for: geo, index: currentCell)
            }
        }
    }
}

#Preview {
    let rows = 10
    let cols = 10
    return GridCells(
        rows: rows,
        cols: cols,
        lineWidth: 1.0,
        inset: 8.0,
        states: .init(rows, cols, Grid.Initializers.random)
    )
    .aspectRatio(1.0, contentMode: .fit)
}

