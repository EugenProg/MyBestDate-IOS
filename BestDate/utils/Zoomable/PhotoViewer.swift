//
//  ZoomableScrollView.swift
//  BestDate
//
//  Created by Евгений on 19.06.2022.
//

import SwiftUI

struct PhotoViewer: View {
    @State var image: UIImage

    @GestureState private var scaleState: CGFloat = 1
    @GestureState private var offsetState = CGSize.zero

    @State private var offset = CGSize.zero
    @State private var scale: CGFloat = 1

    @Binding var currentZoom: CGFloat
    @Binding var currentOffset: CGSize

    var maxZoom: CGFloat = 2.5
    var minZoom: CGFloat = 1
    let frameSize: CGFloat

    var magnification: some Gesture {
        MagnificationGesture()
            .updating($scaleState) { currentState, gestureState, _ in
                gestureState = currentState
            }
            .onEnded { value in
                let zoom = scale * value * scaleState
                if zoom > maxZoom {
                    scale = maxZoom
                } else if zoom < minZoom {
                    scale = minZoom
                } else {
                    scale *= value
                }
                setOffset(size: CGSize.zero)
                currentZoom = scale * scaleState
            }
    }

    var dragGesture: some Gesture {
        DragGesture()
            .updating($offsetState) { currentState, gestureState, _ in
                gestureState = currentState.translation
            }.onEnded { value in
                setOffset(size: value.translation)
            }
    }

    private func setOffset(size: CGSize) {
        let currentHeight = offset.height + size.height + offsetState.height
        let currentWidth = offset.width + size.width + offsetState.width
        let normalWidth = ((getImageWidth() * (scale * scaleState)) - frameSize) / 2
        let normalHeight = ((getImageHeight() * (scale * scaleState)) - frameSize) / 2

        if currentWidth > normalWidth {
            offset.width = offsetState.width - (-normalWidth)
        } else if currentWidth < -normalWidth {
            offset.width = offsetState.width - normalWidth
        } else {
            offset.width += size.width
        }

        if currentHeight > normalHeight {
            offset.height = offsetState.height - (-normalHeight)
        } else if currentHeight < -normalHeight {
            offset.height = offsetState.height - normalHeight
        } else {
            offset.height += size.height
        }

        currentOffset = CGSize(width: offset.width + offsetState.width, height: offset.height + offsetState.height)
    }

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .scaleEffect(scale * scaleState)
            .offset(x: offset.width + offsetState.width, y: offset.height + offsetState.height)
            .gesture(SimultaneousGesture(magnification, dragGesture))
    }

    private func getImageWidth() -> CGFloat {
        return image.size.width > image.size.height ? frameSize * (image.size.width / image.size.height) : frameSize
    }

    private func getImageHeight() -> CGFloat {
        return image.size.height > image.size.width ? frameSize * (image.size.height / image.size.width) : frameSize
    }
}
