//
//  ImagesListView.swift
//  BestDate
//
//  Created by Евгений on 06.08.2022.
//

import SwiftUI

struct ImagesListView: View {
    @Binding var images: [ProfileImage]
    @Binding var selectedImage: Int
    var selectAction: () -> Void

    @State var proccess: Bool = false
    @State var size: CGFloat = 0

    @State var totalWidth: CGFloat = 0
    @State var startOffset: CGFloat = 0

    @GestureState private var scaleState: CGFloat = 1
    @GestureState private var offsetState = CGSize.zero

    @State private var offset = CGSize.zero
    @State private var scale: CGFloat = 1

    var body: some View {
        VStack(spacing: 42) {
            HStack(spacing: 0) {
                ForEach(images, id: \.id) { image in
                    AsyncImageView(url: image.full_url)
                        .frame(width: size, height: size)
                        .padding(.init(top: 0, leading: 2, bottom: 0, trailing: 2))
                        //.scaleEffect(scale * scaleState)
                }.offset(x: -(startOffset + ((size + 4) * CGFloat(selectedImage))), y: 0)
            }.frame(height: size)

            if images.count > 1 {
                HStack {
                    CircleImageButton(imageName: "ic_arrow_right_white", strokeColor: MyColor.getColor(190, 239, 255, 0.18), shadowColor: MyColor.getColor(80, 110, 126, 0.63), circleSize: .LARGE, loadingProcess: $proccess) {
                        if selectedImage > 0 {
                            withAnimation {
                                selectedImage = selectedImage - 1
                                selectAction()
                            }
                        }
                    }.rotationEffect(Angle(degrees: 180))

                    Spacer()


                    CircleImageButton(imageName: "ic_arrow_right_white", strokeColor: MyColor.getColor(190, 239, 255, 0.18), shadowColor: MyColor.getColor(80, 110, 126, 0.63), circleSize: .LARGE, loadingProcess: $proccess) {
                        if selectedImage < images.count - 1 {
                            withAnimation {
                                selectedImage = selectedImage + 1
                                selectAction()
                            }
                        }
                    }
                }.padding(.init(top: 0, leading: 18, bottom: 0, trailing: 18))
            }
        }.frame(width: UIScreen.main.bounds.width)
            .padding(.init(top: 0, leading: 0, bottom: images.count > 1 ? 100 : 198, trailing: 0))
        .onAppear {
            size = UIScreen.main.bounds.width - 4
            totalWidth = (size + 4) * CGFloat(images.count)
            startOffset = -(totalWidth / 2 - (size / 2 + 2))
        }
        .gesture(SimultaneousGesture(magnification, dragGesture))
    }

    var magnification: some Gesture {
        MagnificationGesture()
            .updating($scaleState) { currentState, gestureState, _ in
                gestureState = currentState
            }
            .onEnded { value in
                scale = 1
            }
    }

    var dragGesture: some Gesture {
        DragGesture()
            .updating($offsetState) { currentState, gestureState, _ in
                gestureState = currentState.translation
            }.onEnded { value in
                //currentOffset = value.translation
            }
    }
}
