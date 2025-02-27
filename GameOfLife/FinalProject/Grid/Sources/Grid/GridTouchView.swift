//
//  GridTouchView.swift
//  Lecture18
//
//  Created by Van Simmons on 10/31/23.
//

import ComposableArchitecture
import SwiftUI

struct GridTouchView: View {
    @State var lastCell: (row: Int, col: Int)? = .none
    var store: ViewStoreOf<GridModel>

    init(store: ViewStoreOf<GridModel>) {
        self.store = store
    }

    func location(
        touch: DragGesture.Value,
        geo: GeometryProxy
    ) -> (Int, Int) {
        let row = Int(touch.location.y / geo.size.height * Double(store.grid.size.rows))
        let col = Int(touch.location.x / geo.size.width * Double(store.grid.size.cols))
        return (row, col)
    }

    var body: some View {
        GeometryReader { touchpad in
            Color.gray
                .opacity(0.01)
                .gesture(
                    DragGesture(
                        minimumDistance: 0.0,
                        coordinateSpace: .named("touchpad")
                    )
                    .onChanged { value in
                        let (row, col) = location(touch: value, geo: touchpad)
                        if lastCell == nil || lastCell?.row != row || lastCell?.col != col{
                            lastCell = (row, col)
                        } else {
                            return
                        }
                        store.send(.toggle(row: row, col: col))
                    }
                    .onEnded { value in
                        lastCell = .none
                    }
                )
        }
        .coordinateSpace(name: "touchpad")
    }
}

import GameOfLife
#Preview {
    let rows = 10
    let cols = 10
    let lineWidth = 1.0
    let inset = 8.0
    let store: StoreOf<GridModel> = .init(
        initialState: .init(
            lineWidth: lineWidth,
            inset: inset,
            grid: .init(rows, cols, Grid.Initializers.random)
        ),
        reducer: GridModel.init
    )

    return WithViewStore(store, observe: { $0 }) { store in
        VStack {
            Spacer()
            HStack {
                Spacer()
                GridTouchView(store: store)
                    .aspectRatio(1.0, contentMode: .fit)
                Spacer()
            }
            Spacer()
        }
    }
}

