//
//  ConfigurationView.swift
//  SwiftUIGameOfLife
//

import ComposableArchitecture
import SwiftUI
import GameOfLife

public struct ConfigurationView: View {
    let store: StoreOf<ConfigurationModel>
    @Environment(\.colorScheme) var colorScheme

    public init(store: StoreOf<ConfigurationModel>) {
        self.store = store
    }

    public var body: some View {
        ZStack {
            
            GeometryReader { geometry in
                Image(colorScheme == .dark ? "ConfigurationBackgroundDark" : "ConfigurationBackgroundLight")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.8)
                    .scaleEffect(1.03)
                    .animation(
                        .easeInOut(duration: 6.0).repeatForever(autoreverses: true),
                        value: colorScheme
                    )
            }

            WithViewStore(store, observe: { $0 }) { store in
                NavigationLink(destination: GridEditorView(store: self.store)) {
                    VStack {
                        
                        HStack {
                            Text(store.configuration.title)
                                .font(.system(size: 24.0))
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .scaleEffect(1.1)
                                .animation(
                                    Animation.interpolatingSpring(stiffness: 100, damping: 5)
                                        .repeatForever(autoreverses: true),
                                    value: store.configuration.title
                                )
                            Spacer()
                        }
                        .padding(.bottom, 4.0) // Adjust padding for better spacing

                        // Problem 3b - Shape description
                        HStack {
                            Text(store.configuration.shape)
                                .font(.system(size: 14.0))
                                .foregroundColor(Color.gray)
                                .scaleEffect(1.05)
                                .animation(
                                    Animation.interpolatingSpring(stiffness: 80, damping: 6)
                                        .repeatForever(autoreverses: true),
                                    value: store.configuration.shape
                                )
                            Spacer()
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.85))
                            .shadow(color: .gray, radius: 5, x: 0, y: 2)
                            .scaleEffect(1.03)
                            .animation(
                                Animation.interpolatingSpring(stiffness: 120, damping: 8)
                                    .repeatForever(autoreverses: true),
                                value: store.configuration.title
                            )
                    )
                    .padding(.horizontal, 20) // Adjust horizontal padding
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

#Preview {
    ConfigurationView(
        store: StoreOf<ConfigurationModel>(
            initialState: try! .init(
                configuration: .init(
                    title: "Demo", // Problem 3a
                    contents: [[1, 1]] // Problem 3b
                )
            ),
            reducer: ConfigurationModel.init
        )
    )
}
