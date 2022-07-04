//
//  SeekBarView.swift
//  BestDate
//
//  Created by Евгений on 30.06.2022.
//

import SwiftUI

struct SeekBarView: View {
    @State var start: CGFloat
    @State var end: CGFloat
    @Binding var number: Int
    @State var offset: CGFloat = 0
    @State var trackWidth: CGFloat = 0

    @State var distance: CGFloat = 0

    @GestureState private var offsetState = CGSize.zero

    var buttonOffset = (UIScreen.main.bounds.width - 80) / 2
    var viewWidth = UIScreen.main.bounds.width - 80

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
                    .padding(.init(top: 0, leading: 6, bottom: 0, trailing: 0))

                Spacer()
            }

            HStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(MyColor.getColor(104, 109, 113))
                    .frame(width: 8, height: 8)

                Spacer()

                RoundedRectangle(cornerRadius: 4)
                    .fill(ColorList.main_30_without_opacity.color)
                    .frame(width: 8, height: 8)
            }

            SeekBarButtonView(number: $number)
                .offset(x: -buttonOffset + offset + offsetState.width, y: 0)
                .gesture(dragGesture)
        }.frame(width: viewWidth, height: 170, alignment: .leading)
            .padding(.init(top: 0, leading: 40, bottom: 0, trailing: 40))
            .onAppear {
                if CGFloat(number) < start || CGFloat(number) > end {
                    number = Int(start + (end - start) / 2)
                }
                distance = (viewWidth) / (end - start)
                offset = distance * (CGFloat(number) - start)
                trackWidth = offset
            }
    }

    var dragGesture: some Gesture {
        DragGesture()
            .updating($offsetState) { currentState, gestureState, _ in
                let number = ((offset + offsetState.width) / distance) + start
                if number >= start && number <= end {
                    gestureState = currentState.translation
                }
            }
            .onChanged { _ in
                let newNumber = ((offset + offsetState.width) / distance) + start
                if newNumber >= start && newNumber <= end {
                    number = Int(round(newNumber))
                }
                let width = offset + offsetState.width
                if width > 8 && width < viewWidth - 16 {
                    trackWidth = width
                }
            }
            .onEnded { value in
                offset = distance * (CGFloat(number) - start)
            }
    }
}
