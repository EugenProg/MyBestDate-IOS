//
//  SaveAndSetPositionScrollView.swift
//  BestDate
//
//  Created by Евгений on 13.08.2022.
//

import SwiftUI

struct SaveAndSetPositionScrollView<Content: View>: View {
    let startPosition: CGFloat
    let offsetChanged: (CGFloat) -> Void
    let onRefresh: OnRefresh
    let content: Content

    @State private var state = RefreshState.waiting
    @State private var currentOffset: CGFloat = 0

    init(
            startPosition: CGFloat = 0,
            offsetChanged: @escaping (CGFloat) -> Void = { _ in },
            onRefresh: @escaping OnRefresh,
            @ViewBuilder content: () -> Content
        ) {
            self.startPosition = startPosition
            self.offsetChanged = offsetChanged
            self.onRefresh = onRefresh
            self.content = content()
        }

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                ZStack(alignment: .top) {
                    PositionIndicators(type: .moving)
                        .frame(height: 0)

                    content
                        .alignmentGuide(.top, computeValue: { _ in
                            (state == .loading) ? -THRESHOLD : 0
                        })

                    ZStack {
                        Circle()
                            .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.1))
                            .frame(width: THRESHOLD, height: THRESHOLD)
                        ProgressView()
                            .tint(ColorList.white.color)
                            .frame(width: 50, height: 50)
                    }.offset(y: (state == .loading) ? 0 : -THRESHOLD)
                        .opacity((currentOffset < 1) ? 0 : 1)
                }
            }
            .background(PositionIndicators(type: .fixed))
            .onPreferenceChange(PositionPreferenceKey.self) { values in
                DispatchQueue.main.async {
                    let movingY = values.first { $0.type == .moving }?.y ?? 0
                    let fixedY = values.first { $0.type == .fixed }?.y ?? 0
                    let offset = movingY - fixedY

                    currentOffset = offset
                    if offset > 0 {
                        offsetChanged(offset)
                    }

                    if offset > THRESHOLD && state == .waiting {
                        state = .primed
                    } else if offset < THRESHOLD && state == .primed {
                        state = .loading
                        onRefresh { withAnimation{ state = .waiting } }
                    }
                }
            }
            .onAppear {
                proxy.scrollTo(Int(round(startPosition)), anchor: .top)
            }
        }
    }
}

private enum PositionType {
    case fixed
    case moving
}

private struct Position: Equatable {
    let type: PositionType
    let y: CGFloat
}

private struct PositionPreferenceKey: PreferenceKey {
    typealias Value = [Position]
    static var defaultValue: Value = [Position]()

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}

private struct PositionIndicators: View {
    let type: PositionType

    var body: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(key: PositionPreferenceKey.self,
                            value: [Position(type: type, y: proxy.frame(in: .global).minY)])
        }
    }
}

public typealias RefreshComplete = () -> Void

public typealias OnRefresh = (@escaping RefreshComplete) -> Void

private let THRESHOLD: CGFloat = 50

public enum RefreshState {
    case waiting, primed, loading
}
