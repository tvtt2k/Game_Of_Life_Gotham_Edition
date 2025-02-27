//
//  Simulation.swift
//  SwiftUIGameOfLife
//
import ComposableArchitecture
import Combine
import Dispatch
import Foundation
import Grid
import GameOfLife


@Reducer
public struct SimulationModel {
    @ObservableState
    public struct State: Equatable, Codable {
        public var grid: GridModel.State
        public var isRunningTimer = false
        public var wasRunningTimer = false
        public var shouldRestartTimer = false
        public var timerInterval = 0.5

        public var rows: Double { Double(grid.grid.size.rows) }
        public var gridRotationAngle: Double = 0.0 // Add this line

        public init(grid: GridModel.State = GridModel.State(grid: .init())) {
            self.grid = grid
        }

    }

        
    public enum Action {
        case appear
        case disappear
        case setGridSize(Double)
        case update(grid: Grid)
        case setTimerInterval(Double)
        case stepGrid
        case resetGridToEmpty
        case resetGridToRandom
        case tick
        case startTimer
        case stopTimer
        case setShouldRestartTimer(Bool)
        case toggleTimer(Bool)
        case grid(action: GridModel.Action)
        case rotateGrid
    }

    enum Identifiers: Hashable {
        case simulationTimer
        case simulationCancellable
    }

    public static let scheduler: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()

    public static func timerPublisher(
        _ period: Double
    ) -> () -> AnyPublisher<SimulationModel.Action, Never> {
        {
            Timer.publish(every: period, on: RunLoop.main, in: .common)
                .autoconnect()
                .map { _ in .tick }
                .eraseToAnyPublisher()
        }
    }

    public init() { }

    public var body: some ReducerOf<Self> {
        Scope(
            state: \.grid,
            action: \.grid,
            child: GridModel.init
        )

        Reduce { state, action in
            switch action {
                // Your Problem 6B code modifies the two cases below
                case .appear:
                    if state.wasRunningTimer {
                        state.isRunningTimer = true
                        return Effect.publisher(SimulationModel.timerPublisher(state.timerInterval))
                            .cancellable(id: SimulationModel.Identifiers.simulationCancellable)
                    }
                    return .none
                case .rotateGrid:
                    state.gridRotationAngle += 360.0 // Increment the rotation angle
                    return .none

                case .disappear:
                    state.wasRunningTimer = state.isRunningTimer
                    state.isRunningTimer = false
                    return .cancel(id: SimulationModel.Identifiers.simulationCancellable)

                case .setGridSize(let newSize):
                    state.grid.grid = Grid(Int(newSize), Int(newSize), Grid.Initializers.empty)
                    state.grid.history.reset(with: state.grid.grid)
                    return .none
                case .update(grid: let grid):
                    state.grid.grid = grid
                    state.grid.history = Grid.History()
                    state.grid.history.add(state.grid.grid)
                    return .none
                case .setTimerInterval(let interval):
                    state.isRunningTimer = false
                    state.timerInterval = interval == 0.0 ? 0.01 : interval
                    return Effect.publisher { Just(.stopTimer) }
                case .resetGridToEmpty:
                    state.isRunningTimer = false
                    state.grid.grid = Grid(
                        state.grid.grid.size.rows,
                        state.grid.grid.size.cols,
                        Grid.Initializers.empty
                    )
                    state.grid.history = Grid.History()
                    state.grid.history.add(state.grid.grid)
                    return Effect.publisher { Just(.stopTimer) }
                case .resetGridToRandom:
                    state.isRunningTimer = false
                    state.grid.grid = Grid(
                        state.grid.grid.size.rows,
                        state.grid.grid.size.cols,
                        Grid.Initializers.random
                    )
                    state.grid.history = Grid.History()
                    state.grid.history.add(state.grid.grid)
                    return Effect.publisher { Just(.stopTimer) }
                case .stepGrid:
                    state.isRunningTimer = false
                    state.grid.grid = state.grid.grid.next
                    state.grid.history = Grid.History()
                    return Effect.publisher { Just(.stopTimer) }
                case .tick:
                    state.grid.grid = state.grid.grid.next
                    state.grid.history.add(state.grid.grid)
                    return state.grid.history.cycleLength == .none
                    ? .none
                    : Effect.publisher { Just(.stopTimer) }
                case .startTimer:
                    state.grid.history.reset(with: state.grid.grid)
                    state.isRunningTimer = true
                    return Effect
                        .publisher(SimulationModel.timerPublisher(state.timerInterval))
                        .cancellable(id: SimulationModel.Identifiers.simulationCancellable)
                case .stopTimer:
                    state.isRunningTimer = false
                    return .cancel(id: SimulationModel.Identifiers.simulationCancellable)
                case .setShouldRestartTimer(let shouldRestart):
                    state.shouldRestartTimer = shouldRestart
                    return Effect.publisher { [state] in
                        (state.shouldRestartTimer ? Just(.stopTimer) : Just(.startTimer))
                    }
                case .toggleTimer(let onOff):
                    return Effect.publisher { Just(onOff ? .startTimer : .stopTimer) }
                case .grid(action:):
                    return .none
            }
        }
    }
}

