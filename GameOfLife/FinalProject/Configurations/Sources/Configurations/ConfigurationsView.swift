//
//  ConfigurationsView.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 5/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import SwiftUI
import ComposableArchitecture
import Configuration
import Theming

public struct ConfigurationsView: View {
    let store: StoreOf<ConfigurationsModel>

    public init(store: StoreOf<ConfigurationsModel>) {
        self.store = store
    }

    public var body: some View {
        // Your problem 3A code starts here.
        NavigationView {
            ZStack {
                Color("configBackground", bundle: Theming.bundle).ignoresSafeArea()
                
                WithViewStore(store, observe: { $0 }) { store in
                    VStack {
                        List {
                            ForEachStore(
                                self.store.scope(
                                    state: \.configurations,
                                    action: \.configuration
                                ),
                                content: ConfigurationView.init(store:)
                            ).listRowBackground(Color("configBackground", bundle: Theming.bundle))
                        }
                        .scrollContentBackground(.hidden)
                        
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                store.send(.fetch)
                            }) {
                                Text("Fetch").font(.system(size: 24.0, weight: .bold))
                            }
                            .padding([.top, .bottom], 8.0)
                            
                            Spacer()
                            
                            Button(action: {
                                store.send(.clear)
                            }) {
                                Text("Clear").font(.system(size: 24.0, weight: .bold))
                            }
                            .padding([.top, .bottom], 8.0)
                            
                            Spacer()
                        }
                        .padding([.top, .bottom], 8.0)
                    }
                    // Problem 5A goes here
                    .sheet(
                        isPresented: store.binding(
                            get: \.isAdding,
                            send: ConfigurationsModel.Action.stopAdding
                        ),
                        content: {
                            AddConfigurationView(
                                store: self.store.scope(
                                    state: \.addConfigState,
                                    action: ConfigurationsModel.Action.addConfig(action:)
                                )
                            )
                        }
                    )
                    // Problem 3B goes here
                    .navigationBarTitle("Configuration")
                    .navigationBarHidden(false)
                    // Problem 5B goes here
                    .navigationBarItems(
                        trailing: Button("Add") {
                            self.store.send(.add)
                        }
                    )
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        // Problem 3A Ends here
    }
}

#Preview {
    let previewState = ConfigurationsModel.State()
    return ConfigurationsView(
        store: Store(
            initialState: previewState,
            reducer: ConfigurationsModel.init
        )
    )
}
