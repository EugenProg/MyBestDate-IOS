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
    @Binding var showButtons: Bool
    var selectAction: () -> Void

    @State var proccess: Bool = false
    @State var size: CGFloat = 0

    @State var totalWidth: CGFloat = 0
    @State var startOffset: CGFloat = 0

    @GestureState private var scaleState: CGFloat = 1
    @GestureState private var offsetState = CGSize.zero

    @State private var offset = CGSize.zero

    var body: some View {
        VStack(spacing: 42) {
            HStack(spacing: 0) {
                ForEach(images.indices, id: \.self) { index in
                    let image = images[index]
                    AsyncImageView(url: image.full_url)
                        .frame(width: size, height: size)
                        .padding(.init(top: 0, leading: 2, bottom: 0, trailing: 2))
                        .opacity(selectedImage == index ? 1 : 0)
                        .scaleEffect(scaleState)
                }.offset(x: offset.width)
            }.frame(height: size)

            HStack(spacing: 6) {
                CircleImageButton(imageName: "ic_arrow_right_white", strokeColor: MyColor.getColor(190, 239, 255, 0.18), shadowColor: MyColor.getColor(80, 110, 126, 0.63), circleSize: .LARGE, loadingProcess: $proccess) {
                    previousAction()
                }.rotationEffect(Angle(degrees: 180))
                    .opacity(showButtons ? 1 : 0)

                Spacer()

                ForEach(0..<images.count, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 3)
                        .fill(selectedImage == index ? ColorList.white_80.color : ColorList.white_40.color)
                        .frame(width: 6, height: 6)

                }

                Spacer()

                CircleImageButton(imageName: "ic_arrow_right_white", strokeColor: MyColor.getColor(190, 239, 255, 0.18), shadowColor: MyColor.getColor(80, 110, 126, 0.63), circleSize: .LARGE, loadingProcess: $proccess) {
                    nextAction()
                }.opacity(showButtons ? 1 : 0)
            }.padding(.init(top: 0, leading: 18, bottom: 0, trailing: 18))

        }.frame(width: UIScreen.main.bounds.width)
            .padding(.init(top: 0, leading: 0, bottom: images.count > 1 ? 100 : 198, trailing: 0))
        .onAppear {
            size = UIScreen.main.bounds.width - 4
            totalWidth = (size + 4) * CGFloat(images.count)
            startOffset = -(totalWidth / 2 - (size / 2 + 2))
            calculateOffset()
        }
        .gesture(SimultaneousGesture(magnification, dragGesture))
    }

    var magnification: some Gesture {
        MagnificationGesture()
            .updating($scaleState) { currentState, gestureState, _ in
                gestureState = currentState
            }
    }

    var dragGesture: some Gesture {
        DragGesture()
            .updating($offsetState) { currentState, gestureState, _ in
                gestureState = currentState.translation
            }.onEnded { value in
                if -value.translation.width > (50) {
                    nextAction()
                } else if value.translation.width > (50) {
                    previousAction()
                }
            }
    }

    func nextAction() {
        if selectedImage < images.count - 1 {
            withAnimation {
                selectedImage = selectedImage + 1
                selectAction()
                calculateOffset()
            }
        }
    }

    func previousAction() {
        if selectedImage > 0 {
            withAnimation {
                selectedImage = selectedImage - 1
                selectAction()
                calculateOffset()
            }
        }
    }

    func calculateOffset() {
        offset.width = -(startOffset + ((size + 4) * CGFloat(selectedImage)))
    }
}
