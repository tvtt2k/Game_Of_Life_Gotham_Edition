//
//  AddConfigsModel.swift
//
//
import Combine
import ComposableArchitecture
import GameOfLife

@Reducer
public struct AddConfigModel {
    @ObservableState
    public struct State: Equatable, Codable {
        public var title: String
        public var counter: CounterModel.State

        public init(title: String = "", counter: CounterModel.State = CounterModel.State()) {
            self.title = title
            self.counter = counter
        }
    }

    public enum Action: Equatable {
        case updateTitle(String)
        case counter(action: CounterModel.Action)
        case cancel
        case ok(GameOfLife.Grid.Configuration)
    }

    public init() { }

    public var body: some ReducerOf<Self> {
        Scope(
            state: \.counter,
            action: \.counter,
            child: CounterModel.init
        )

        Reduce { state, action in
            switch action {
                case .updateTitle(let title):
                    state.title = title
                    return .none
                case .cancel:
                    return .none
                case .ok:
                    return .none
                case .counter:
                    return .none
            }
        }
    }
}
