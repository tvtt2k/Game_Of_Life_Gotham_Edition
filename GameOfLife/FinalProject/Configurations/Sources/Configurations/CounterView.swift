//
//  CounterView.swift
//  FinalProject
//
import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    let store: StoreOf<CounterModel>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            HStack {
                Button("−") { store.send(.decrementButtonTapped) }
                Text("\(store.count)")
                    .font(Font.title.monospacedDigit())
                Button("+") { store.send(.incrementButtonTapped) }
            }
        }
    }
}

#Preview {
    CounterView(
        store: StoreOf<CounterModel>(
            initialState: .init(count: 10),
            reducer: CounterModel.init
        )
    )
}
