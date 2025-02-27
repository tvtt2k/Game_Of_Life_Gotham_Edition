//
//  SwiftUIGameOfLifeApp.swift
//  FinalProject
//

import Foundation
import SwiftUI
import ComposableArchitecture

@main
struct SwiftUIGameOfLife: App {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.orange
        ]
    }
    let store = Store(
        initialState: ApplicationModel.State(),
        reducer: ApplicationModel.init
    )

    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
