//
//  ThemedButton.swift
//  SwiftUIGameOfLife
//

import SwiftUI

public struct ThemedButton: View {
    public var text: String
    public var action: () -> Void

    @State private var isPressed: Bool = false // Track button press state

    public init(
        text: String,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.action = action
    }

    public var body: some View {
        HStack {
            Spacer()
            Button(action: {
                // Perform the button action
                withAnimation(.easeInOut(duration: 0.2)) {
                    isPressed = true
                }
                action()

                // Reset animation state after a short delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isPressed = false
                    }
                }
            }) {
                Text(text)
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: 80.0, height: 44.0)
                    .scaleEffect(isPressed ? 1.1 : 1.0) // Add scaling effect
                    .animation(.easeInOut(duration: 0.2), value: isPressed)
            }
            .background(isPressed ? Color("accent", bundle: Theming.bundle).opacity(0.8) : Color("accent", bundle: Theming.bundle))
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(isPressed ? Color.blue : Color.indigo, lineWidth: 4.0) // Change color on press
                    .animation(.easeInOut(duration: 0.2), value: isPressed)
            )
            .shadow(color: isPressed ? Color.blue.opacity(0.5) : .black, radius: isPressed ? 4.0 : 2.0) // Change shadow on press
            .scaleEffect(isPressed ? 1.1 : 1.0) // Scale the button
            .animation(.easeInOut(duration: 0.2), value: isPressed)
            Spacer()
        }
    }
}

// MARK: Previews
#Preview {
    ThemedButton(text: "Step") { }
        .background(Color("themingTestColor", bundle: Theming.bundle))
}

