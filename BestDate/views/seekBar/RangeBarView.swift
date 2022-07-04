//
//  RangeBarView.swift
//  BestDate
//
//  Created by Евгений on 03.07.2022.
//

import SwiftUI

struct RangeBarView: View {
    @State var start: CGFloat
    @State var end: CGFloat

    @State var distance: CGFloat = 0

    @Binding var startNumber: Int
    @State var startOffset: CGFloat = 0

    @GestureState private var startOffsetState = CGSize.zero

    @Binding var endNumber: Int
    @State var endOffset: CGFloat = 0

    @GestureState private var endOffsetState = CGSize.zero

    @State var trackWidth: CGFloat = 0

    var buttonOffset = (UIScreen.main.bounds.width - 130) / 2
    var viewWidth = UIScreen.main.bounds.width - 130

    var body: some View {
        ZStack {
            Rectangle()
                .fill(ColorList.main_30_without_opacity.color)
                .frame(height: 5)
                .padding(.init(top: 0, leading: 6, bottom: 0, trailing: 6))

            HStack {
            Rectangle()
                .fill(LinearGradient(colors: [
                    ColorList.main_50.color,
                    ColorList.main.color,
                    ColorList.main_50.color
                ], startPoint: .leading, endPoint: .trailing))
                .frame(width: trackWidth, height: 5)
                Spacer()
            }
            .offset(x: startOffset + startOffsetState.width, y: 0)

            HStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(ColorList.main_30_without_opacity.color)
                    .frame(width: 8, height: 8)

                Spacer()

                RoundedRectangle(cornerRadius: 4)
                    .fill(ColorList.main_30_without_opacity.color)
                    .frame(width: 8, height: 8)
            }

            SeekBarButtonView(number: $startNumber, buttonSize: 54, circleSize: 32)
                .offset(x: -buttonOffset + startOffset + startOffsetState.width, y: 0)
                .gesture(startDragGesture)

            SeekBarButtonView(number: $endNumber, buttonSize: 54, circleSize: 32)
                .offset(x: -buttonOffset + endOffset + endOffsetState.width, y: 0)
                .gesture(endDragGesture)

        }.frame(width: viewWidth, height: 65, alignment: .leading)
            .onAppear {
                distance = (viewWidth) / (end - start)

                if CGFloat(startNumber) < start || startNumber > endNumber {
                    startNumber = Int(start + 10)
                }
                startOffset = distance * (CGFloat(startNumber) - start)

                if CGFloat(endNumber) > end || endNumber < startNumber {
                    endNumber = Int(end - 10)
                }
                endOffset = distance * (CGFloat(endNumber) - start)

                calculateTrackWidth()
            }
    }

    var startDragGesture: some Gesture {
        DragGesture()
            .updating($startOffsetState) { currentState, gestureState, _ in
                let number = ((startOffset + startOffsetState.width) / distance) + start
                if number >= start && number <= end && Int(number) < endNumber {
                    gestureState = currentState.translation
                }
            }
            .onChanged { _ in
                let newNumber = ((startOffset + startOffsetState.width) / distance) + start
                if newNumber >= start && newNumber <= end {
                    startNumber = Int(round(newNumber))
                }
                calculateTrackWidth()
            }
            .onEnded { value in
                if endNumber - startNumber < 1 {
                    startNumber = endNumber - 2
                }
                startOffset = distance * (CGFloat(startNumber) - start)
            }
    }

    var endDragGesture: some Gesture {
        DragGesture()
            .updating($endOffsetState) { currentState, gestureState, _ in
                let number = ((endOffset + endOffsetState.width) / distance) + start
                if number >= start && number <= end && Int(number) > startNumber {
                    gestureState = currentState.translation
                }
            }
            .onChanged { _ in
                let newNumber = ((endOffset + endOffsetState.width) / distance) + start
                if newNumber >= start && newNumber <= end {
                    endNumber = Int(round(newNumber))
                }
                calculateTrackWidth()
            }
            .onEnded { value in
                if endNumber - startNumber < 1 {
                    endNumber = startNumber + 2
                }
                endOffset = distance * (CGFloat(endNumber) - start)
            }
    }

    private func calculateTrackWidth() {
        let track = (endOffset + endOffsetState.width) - (startOffset + startOffsetState.width) - 8
        trackWidth = track < 8 ? 8 : track
    }
}

