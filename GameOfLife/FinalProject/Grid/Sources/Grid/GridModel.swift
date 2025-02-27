//
//  GridModel.swift
//  Lecture18
//
//  Created by Van Simmons on 11/2/23.
//

import ComposableArchitecture
import GameOfLife

public struct GridModel: Reducer {
    public struct State: Equatable, Codable {
        var lineWidth: Double
        var inset: Double
        var rotation: Double
        var isFlashing: Bool = false
        // added these two
        var fractionComplete: Double = 0.0
        var trigger = false
        public var gridRotationAngle: Double = 0.0 // Add rotation state
        var gridLinesRotationAngle: Double = 0.0
        var isScaling: Bool = false
        public var grid: GameOfLife.Grid
        public var history: GameOfLife.Grid.History


        public init(
            lineWidth: Double = 2.0,
            inset: Double = 2.0,
            rotation: Double = 0.0,
            history: Grid.History = Grid.History(),
            grid: GameOfLife.Grid = .init()
        ) {
            self.lineWidth = lineWidth
            self.inset = inset
            self.rotation = rotation
            self.grid = grid
            self.history = history
            self.history.add(grid)
        }
    }

    public enum Action {
        case step
        case toggle(row: Int, col: Int)
        case rotateGrid
        case rotateGridLines
        // added these two
       // case animate
        //case start
    }

    public init() { }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .step:
                // remove the grid
                state.lineWidth = state.lineWidth > 3 ? 2.0 : 10.0
                    return .none
                case let .toggle(row: row, col: col):
                    state.grid.toggle(row, col)
                    return .none
                case .rotateGrid:
                    state.gridRotationAngle += 360.0
                    state.isFlashing.toggle()
                    state.isScaling.toggle()
                    return .none
                case .rotateGridLines:
                    state.gridLinesRotationAngle += 90.0
                    if state.gridLinesRotationAngle >= 360.0 {
                        state.gridLinesRotationAngle = 0.0 // Reset after full rotation
                    }
                    //state.isScaling.toggle()
                    return .none

            }
        }
    }
}
