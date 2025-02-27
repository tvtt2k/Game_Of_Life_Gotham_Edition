//
//  AddConfigurationView.swift
//  FinalProject
//

import SwiftUI
import ComposableArchitecture
import Combine
import Theming
import GameOfLife

struct AddConfigurationView: View {
    @Bindable var store: StoreOf<AddConfigModel>

    init(store: StoreOf<AddConfigModel>) {
        self.store = store
    }
    var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            VStack {
                Spacer()
                VStack {
                    //Problem 5C Goes inside the following HStacks...
                    HStack {
                        Spacer()
                        Text("Title:")
                            .foregroundColor(Color.gray)
                            .padding(.trailing, 8.0)
                        TextField("Title",
                            text: store.binding(
                                get: \.title,
                                send: AddConfigModel.Action.updateTitle
                            )
                        )
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("Size:")
                            .foregroundColor(Color.gray)
                            .padding(.trailing, 8.0)
                        CounterView(
                            store: self.store.scope(
                                state: \.counter,
                                action: AddConfigModel.Action.counter(action:)
                            )
                        )
                        Spacer()
                    }
                }
                .padding()
                .overlay(Rectangle().stroke(Color.gray, lineWidth: 2.0))
                .padding(.bottom, 24.0)

                HStack {
                    Spacer()
                    // Problem 5D - your answer goes in the following buttons
                    ThemedButton(text: "Save") {
                        store.send(.ok(try! GameOfLife.Grid.Configuration(title: store.title, rows: store.counter.count, cols: store.counter.count)))
                    }
                    ThemedButton(text: "Cancel") {
                        store.send(.cancel)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 36.0)
            .padding(.horizontal, 24.0)
            .font(.title)
            .background(Color("configBackground", bundle: Theming.bundle))
        }
    }
}

#Preview {
    AddConfigurationView(
        store: StoreOf<AddConfigModel>(
            initialState: .init(
                title: "",
                counter: .init(count: 10)
            ),
            reducer: AddConfigModel.init
        )
    )
}
