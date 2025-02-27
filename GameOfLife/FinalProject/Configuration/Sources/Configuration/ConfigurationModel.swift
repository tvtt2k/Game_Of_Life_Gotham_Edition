//
//  ConfigurationModel.swift
//  SwiftUIGameOfLife
//
import ComposableArchitecture
import Foundation
import Grid
import GameOfLife

@Reducer
public struct ConfigurationModel {
    @ObservableState
    public struct State: Equatable, Codable, Identifiable {
        public var configuration: Grid.Configuration
        public var grid: GridModel.State
        public var index: Int

        public init(configuration: GameOfLife.Grid.Configuration, style: (GameOfLife.Grid.Configuration) -> Grid = \.defaultGrid) {
            self.configuration = configuration
            self.grid = GridModel.State(
                grid: style(configuration)
            )
            self.index = 0
        }

        public init(
            configuration: GameOfLife.Grid.Configuration,
            grid: GridModel.State = .init(),
            index: Int
        ) {
            self.configuration = configuration
            self.grid = grid
            self.index = index
        }
        public var id: UUID {
            configuration.id
        }
    }

    public enum Action {
        case grid(action: GridModel.Action)
        case simulate(Grid)
    }

    public static let scheduler: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()

    public init() { }

    public var body: some ReducerOf<Self> {
        Scope(
            state: \.grid,
            action: \.grid,
            child: GridModel.init
        )

        Reduce { state, action in
            switch action {
                default:
                    return .none
            }
        }
    }
}
