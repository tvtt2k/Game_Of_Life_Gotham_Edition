//
//  Application.swift
//  SwiftUIGameOfLife
//

import ComposableArchitecture
import Combine
import Simulation
import Configurations
import Configuration
import Statistics
import Foundation
import GameOfLife

@Reducer
struct ApplicationModel {
    @ObservableState
    struct State: Equatable {
        var selectedTab = Tab.simulation
        var simulation = SimulationModel.State()
        var configurations = ConfigurationsModel.State()
        var statistics = StatisticsModel.State()
    }

    enum Action {
        case setSelectedTab(tab: Tab)
        case simulation(action: SimulationModel.Action)
        case configurations(action: ConfigurationsModel.Action)
        case statistics(action: StatisticsModel.Action)
    }

    enum Tab {
        case simulation
        case configuration
        case statistics
    }

    init() { }

    var body: some ReducerOf<Self> {
        Scope(
            state: \.simulation,
            action: \.simulation,
            child: SimulationModel.init
        )

        Scope(
            state: \.configurations,
            action: \.configurations,
            child: ConfigurationsModel.init
        )

        Scope(
            state: \.statistics,
            action: \.statistics,
            child: StatisticsModel.init
        )

        /// Main reducer
        Reduce { state, action in
            switch action {
                case .setSelectedTab(let tab):
                    state.selectedTab = tab
                case .simulation(action: .tick):
                    state.statistics = .init(
                        statistics: state.statistics.statistics.add(
                            state.simulation.grid.grid
                        )
                    )
                    return .none
                case .simulation(action: .resetGridToRandom), .simulation(action: .resetGridToEmpty):
                    return Effect.publisher { Just(ApplicationModel.Action.statistics(action: .reset)) }
                case let .configurations(.configuration(.element(_, .simulate(grid)))):
                    state.simulation.grid.grid = grid
                    return .none
                default:
                    return .none
            }
            return .none
        }
    }
}
