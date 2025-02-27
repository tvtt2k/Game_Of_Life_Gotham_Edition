//
//  FormLine.swift
//

import SwiftUI
import Theming

struct FormLine: View {
    var title: String
    var value: Int
    @Environment(\.colorScheme) var colorScheme // Access the color scheme

    var body: some View {
        Section(
            header: Text("\(title)")
                .font(.title3)
                .bold()
                .foregroundColor(colorScheme == .dark ? .white : .black) // Adjust header color
        ) {
            Text("\(value)")
                .font(.system(.headline, design: .monospaced))
                .foregroundColor(colorScheme == .dark ? .white : Color("accent", bundle: Theming.bundle)) // Adjust value color
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    Form {
        FormLine(
            title: "A",
            value: 20000
        )
    }
}

