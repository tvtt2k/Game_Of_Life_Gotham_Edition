//
//  SimulationView.swift
//  SwiftUIGameOfLife
//

import SwiftUI
import ComposableArchitecture
import Grid
import Theming

public struct SimulationView: View {
    let store: StoreOf<SimulationModel>
    @Environment(\.colorScheme) var colorScheme // Access the color scheme from the environment

    public init(store: StoreOf<SimulationModel>) {
        self.store = store
    }

    public var body: some View {
        NavigationView {
            WithViewStore(store, observe: { $0 }) { store in
                ZStack {
                    // Background image for simulation (light and dark modes)
                    GeometryReader { geometry in
                        Image(colorScheme == .dark ? "SimulationBackgroundDark" : "SimulationBackgroundLight")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped() // Prevents image from overflowing
                            .edgesIgnoringSafeArea(.all)
                    }

                    VStack {
                        GeometryReader { g in
                            if g.size.width < g.size.height {
                                self.verticalContent(for: store, geometry: g)
                            } else {
                                self.horizontalContent(for: store, geometry: g)
                            }
                        }
                    }
                }
                .navigationBarTitle("Simulation")
                .navigationBarHidden(false)
                .onAppear {
                    store.send(.startTimer) // Restart the timer when the view appears
                }
                .onDisappear {
                    store.send(.stopTimer) // Stop the timer when the view disappears
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    func verticalContent(
        for store: ViewStoreOf<SimulationModel>,
        geometry g: GeometryProxy
    ) -> some View {
        VStack {
            InstrumentationView(
                store: self.store,
                width: g.size.width * 0.82
            )
            .frame(height: g.size.height * 0.35)
            .padding(.bottom, 16.0)

            Divider()

            GridView(
                store: self.store.scope(
                    state: \.grid,
                    action: \.grid
                )
            )
        }
    }

    func horizontalContent(
        for store: ViewStoreOf<SimulationModel>,
        geometry g: GeometryProxy
    ) -> some View {
        HStack {
            Spacer()
            InstrumentationView(store: self.store)
            Spacer()
            Divider()
            GridView(
                store: self.store.scope(
                    state: \.grid,
                    action: \.grid
                )
            )
            .frame(width: g.size.height)
            Spacer()
        }
    }
}

#Preview {
    let previewState = SimulationModel.State()
    SimulationView(
        store: Store(
            initialState: previewState,
            reducer: SimulationModel.init
        )
    )
}

