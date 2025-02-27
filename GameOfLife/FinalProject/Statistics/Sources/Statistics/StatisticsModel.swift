//
//  Statistics.swift
//  SwiftUIGameOfLife
//
import ComposableArchitecture
import GameOfLife

@Reducer
public struct StatisticsModel {
    @ObservableState
    public struct State: Equatable, Codable {
        public var statistics: Grid.Statistics = Grid.Statistics.init()

        public init(statistics: Grid.Statistics = Grid.Statistics.init()) {
            self.statistics = statistics
        }
    }
    
    public enum Action {
        case update(grid: Grid)
        case reset
    }

    public init() { }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .update(grid: let grid):
                    state.statistics = state.statistics.add(grid)
                    return .none
                case .reset:
                    state.statistics = Grid.Statistics.init()
                    return .none
            }
        }
    }
}
