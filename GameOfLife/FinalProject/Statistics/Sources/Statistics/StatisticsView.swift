//
//  StatisticsView.swift
//  SwiftUIGameOfLife
//

import SwiftUI
import ComposableArchitecture
import Theming

public struct StatisticsView: View {
    let store: StoreOf<StatisticsModel>
    @Environment(\.colorScheme) var colorScheme // Access the color scheme

    public init(store: StoreOf<StatisticsModel>) {
        self.store = store
    }

    public var body: some View {
        NavigationView {
            ZStack {
                // Animated background for dark mode
                if colorScheme == .dark {
                    GeometryReader { geometry in
                        Image("StatisticsBackgroundDark") // Replace with your dark mode image name
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                            .edgesIgnoringSafeArea(.all)
                            .opacity(0.9)
                            .scaleEffect(1.02)
                            .animation(
                                Animation.easeInOut(duration: 6.0).repeatForever(autoreverses: true),
                                value: colorScheme
                            )
                    }
                }

                VStack {
                    VStack {
                        Form {
                            // Problem 7A - Animating statistics values
                            animatedFormLine(
                                title: "Steps",
                                value: self.store.statistics.steps,
                                color: colorScheme == .dark ? .white : .black
                            )
                            animatedFormLine(
                                title: "Alive",
                                value: self.store.statistics.alive,
                                color: colorScheme == .dark ? .white : .black
                            )
                            animatedFormLine(
                                title: "Die",
                                value: self.store.statistics.died,
                                color: colorScheme == .dark ? .white : .black
                            )
                            animatedFormLine(
                                title: "Born",
                                value: self.store.statistics.born,
                                color: colorScheme == .dark ? .white : .black
                            )
                            animatedFormLine(
                                title: "Empty",
                                value: self.store.statistics.empty,
                                color: colorScheme == .dark ? .white : .black
                            )
                        }

                        // Animating the reset button
                        ThemedButton(text: "Reset") {
                            self.store.send(.reset)
                        }
                        .scaleEffect(1.05)
                        .animation(
                            Animation.spring(response: 1.2, dampingFraction: 0.7)
                                .repeatForever(autoreverses: true),
                            value: self.store.statistics.steps
                        )
                    }
                    .padding(.bottom, 27.0)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationBarTitle(Text("Statistics"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    // Helper method for animated FormLine
    func animatedFormLine(title: String, value: Int, color: Color, animationDuration: Double = 2.0, springStiffness: Double = 100) -> some View {
        FormLine(title: title, value: value)
            .foregroundColor(color) // Apply dynamic text color
            .scaleEffect(1.02)
            .animation(
                Animation.interpolatingSpring(stiffness: springStiffness, damping: 6)
                    .repeatForever(autoreverses: true),
                value: value
            )
            .opacity(0.95)
            .animation(
                Animation.easeInOut(duration: animationDuration).repeatForever(autoreverses: true),
                value: value
            )
    }
}

#Preview {
    let previewState = StatisticsModel.State()
    return StatisticsView(
        store: Store(
            initialState: previewState,
            reducer: StatisticsModel.init
        )
    )
}

