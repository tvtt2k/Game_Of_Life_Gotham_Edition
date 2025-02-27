//
//  InstrumentationView.swift
//  SwiftUIGameOfLife
//

import SwiftUI
import ComposableArchitecture
import Theming

fileprivate let formatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.numberStyle = .decimal
    nf.maximumFractionDigits = 3
    return nf
}()

struct InstrumentationView: View {
    @Bindable var store: StoreOf<SimulationModel>
    private var width: CGFloat

    init(
        store: StoreOf<SimulationModel>,
        width: CGFloat = 300.0
    ) {
        self.store = store
        self.width = width
    }

    var body: some View {
        VStack {
            Spacer()
            control1(width)
                .frame(width: width, alignment: .leading)
                .offset(x: 0.0)
                .fixedSize(horizontal: true, vertical: false)
            control2(width)
                .frame(width: width, alignment: .leading)
                .offset(x: 0.0)
                .fixedSize(horizontal: true, vertical: false)
            control3(width)
                .frame(width: width, alignment: .leading)
                .offset(x: 0.0)
                .fixedSize(horizontal: true, vertical: false)
            control4(width)
                .frame(width: width, alignment: .leading)
                .offset(x: 0.0)
                .fixedSize(horizontal: true, vertical: false)
            buttons
                .frame(width: width, alignment: .top)
                .fixedSize(horizontal: true, vertical: false)
                .padding(.top, 16.0)
            Spacer()
        }
    }

    func control1(_ width: CGFloat) -> some View {
        HStack {
            Text("Size: \(Int(store.grid.grid.size.rows))")
                .font(.system(.subheadline, design: .rounded))
                .bold()
                .foregroundColor(Color("accent"))
                .frame(width: width * 0.65, alignment: .bottomLeading)
                .padding(0.0)
            Spacer()
            Text("Depth")
                .font(.system(.subheadline, design: .rounded))
                .bold()
                .foregroundColor(Color("accent", bundle: Theming.bundle))
                .frame(width: width * 0.25, alignment: .bottomTrailing)
                .padding(0.0)
        }
    }

    func control2(_ width: CGFloat) -> some View {
        HStack {
            Slider(
                value: $store.rows.sending(\.setGridSize),
                in: 5.0 ... 40.0,
                step: 1,
                onEditingChanged: { (changed) in },
                minimumValueLabel: Text("5").font(.system(.subheadline, design: .rounded)).foregroundColor(Color("accent", bundle: Theming.bundle)),
                maximumValueLabel: Text("40").font(.system(.subheadline, design: .rounded)).foregroundColor(Color("accent", bundle: Theming.bundle)),
                label: { Spacer() }
            )
            .frame(width: width * 0.65, alignment: .bottomLeading)
            .accentColor(Color("accent", bundle: Theming.bundle))


            Spacer()

            Text(self.cycleLength(for: store))
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(Color("accent", bundle: Theming.bundle))
                .frame(width: width * 0.25, alignment: .trailing)
                .fixedSize(horizontal: true, vertical: false)
                .background(
                    Color("textBackground", bundle: Theming.bundle)
                        .frame(width: width * 0.25, height: 31.0, alignment: .leading)
                        .fixedSize(horizontal: true, vertical: true)
                )
        }
    }

    func control3(_ width: CGFloat) -> some View {
        HStack {
            Text("Refresh Period: \(self.numberString(for: store.timerInterval))")
                .font(.system(.subheadline, design: .rounded))
                .bold()
                .foregroundColor(Color("accent", bundle: Theming.bundle))
                .frame(width: width * 0.55, alignment: .bottomLeading)
                .offset(x: 0.0)
                .padding(0.0)

            Spacer()

            Text("Simulation")
                .font(.system(.subheadline, design: .rounded))
                .bold()
                .frame(width: width * 0.45, alignment: .bottomTrailing)
                .padding(0.0)
                .foregroundColor(store.isRunningTimer ? .red : Color("accent", bundle: Theming.bundle))
        }
    }

    func control4(_ width: CGFloat) -> some View {
        HStack {
            Slider(
                value: $store.timerInterval.sending(\.setTimerInterval),
                in: 0.0 ... 1.0,
                step: 0.1,
                onEditingChanged: { (changed) in },
                minimumValueLabel: Text("0.0")
                    .font(.system(.subheadline, design: .rounded)).foregroundColor(Color("accent", bundle: Theming.bundle)),
                maximumValueLabel: Text("1.0")
                    .font(.system(.subheadline, design: .rounded)).foregroundColor(Color("accent", bundle: Theming.bundle)),
                label: { Spacer() }
            )
            .frame(width: width * 0.65, alignment: .bottomLeading)
            .accentColor(Color("accent", bundle: Theming.bundle))

            Spacer()

            Toggle(
                isOn: $store.isRunningTimer.sending(\.toggleTimer)
            ) {
                EmptyView()
            }
            .frame(width: width * 0.25, alignment: .bottomTrailing)
        }
    }

    var buttons: some View {
        HStack {
            Spacer()
            ThemedButton(text: "Step") {
                store.send(.stepGrid,animation: .interpolatingSpring)
                store.send(.grid(action: .rotateGrid))
            }
            // Didn't know what else to put :(
            Spacer()
            ThemedButton(text: "Empty") { store.send(.resetGridToEmpty) }
            Spacer()
            ThemedButton(text: "Random") { store.send(.resetGridToRandom) }
            Spacer()
        }
    }

    func cycleLength(for store: StoreOf<SimulationModel>) -> String {
        guard let cycleLength = store.grid.history.cycleLength else { return "" }
        return "\(cycleLength)"
    }

    func numberString(for value: Double) -> String {
        "\(formatter.string(from: NSNumber(value: value) ) ?? "")"
    }
}

#Preview {
    let previewState = SimulationModel.State()
    return InstrumentationView(
        store: Store(
            initialState: previewState,
            reducer: SimulationModel.init
        )
    )
}
