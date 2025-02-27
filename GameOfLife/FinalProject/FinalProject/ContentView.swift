//
//  ContentView.swift
//  SwiftUIGameOfLife
//

import SwiftUI
import ComposableArchitecture
import Simulation
import Configurations
import Statistics
import Theming

struct ContentView: View {
    @Bindable var store: StoreOf<ApplicationModel>

    var body: some View {
        TabView(selection: $store.selectedTab.sending(\.setSelectedTab)) {
            self.simulationView()
                .tag(ApplicationModel.Tab.simulation)
            self.configurationsView()
                .tag(ApplicationModel.Tab.configuration)
            self.statisticsView()
                .tag(ApplicationModel.Tab.statistics)
        }
        .accentColor(Color("accent", bundle: Theming.bundle))
        .tint(Color.accentColor)
    }

    private func simulationView() -> some View {
        SimulationView(
            store: self.store.scope(
                state: \.simulation,
                action: \.simulation
            )
        )
        .tabItem {
            Image(systemName: "circle.grid.cross.up.filled")
            Text("Simulation")
        }
    }

    private func configurationsView() -> some View {
        ConfigurationsView(
            store: self.store.scope(
                state: \.configurations,
                action: \.configurations
            )
        )
        .tabItem {
            Image(systemName: "wrench.and.screwdriver")
            Text("Configuration")
        }
    }

    private func statisticsView() -> some View {
        StatisticsView(
            store: store.scope(
                state: \.statistics,
                action: \.statistics
            )
        )
        .tabItem {
            Image(systemName: "ruler.fill")
            Text("Statistics")
        }
    }
}

#Preview {
    let previewState = ApplicationModel.State()
    ContentView(
        store: Store(
            initialState: previewState,
            reducer: ApplicationModel.init
        )
    )
}
