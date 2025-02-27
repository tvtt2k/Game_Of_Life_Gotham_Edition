//
//  GridLines.swift
//  Lecture16
//
//  Created by Van Simmons on 10/26/23.
//

import ComposableArchitecture
import GameOfLife
import SwiftUI
import Theming

struct GridLines: View {
    let rows: Int
    let cols: Int
    let lineWidth: Double
    let rotationAngle: Double // Add rotation angle

    // Geometry calculations
    var halfWidth: Double { lineWidth / 2.0 }
    func cellX(for row: Int, in geo: GeometryProxy) -> Double {
        Double(row) * geo.size.width / Double(cols)
    }
    func cellY(for col: Int, in geo: GeometryProxy) -> Double {
        Double(col) * geo.size.height / Double(rows)
    }
    func topVertical(for col: Int, in geo: GeometryProxy) -> CGPoint {
        .init(x: cellX(for: col, in: geo), y: -halfWidth)
    }
    func bottomVertical(for col: Int, in geo: GeometryProxy) -> CGPoint {
        .init(x: cellX(for: col, in: geo), y: geo.size.height + halfWidth)
    }
    func leftHorizontal(for row: Int, in geo: GeometryProxy) -> CGPoint {
        .init(x: -halfWidth, y: cellY(for: row, in: geo))
    }
    func rightHorizontal(for row: Int, in geo: GeometryProxy) -> CGPoint {
        .init(x: geo.size.width + halfWidth, y: cellY(for: row, in: geo))
    }

    var body: some View {
        GeometryReader { geo in
            Path { pencil in
                (0 ... cols).forEach { col in
                    pencil.move(to: CGPoint(x: geo.size.width * Double(col) / Double(cols), y: 0))
                    pencil.addLine(to: CGPoint(x: geo.size.width * Double(col) / Double(cols), y: geo.size.height))
                }

                (0 ... rows).forEach { row in
                    pencil.move(to: CGPoint(x: 0, y: geo.size.height * Double(row) / Double(rows)))
                    pencil.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height * Double(row) / Double(rows)))
                }
            }
            .stroke(Color("gridLine", bundle: Theming.bundle), lineWidth: lineWidth)
        }
        .rotationEffect(Angle(degrees: rotationAngle)) // Apply rotation effect
        .animation(.easeInOut(duration: 1.0), value: rotationAngle) // Smooth animation
    }
}

#Preview {
    GridLines(
        rows: 40,
        cols: 20,
        lineWidth: 2.0,
        rotationAngle: 90 // Example rotation
    )
}
