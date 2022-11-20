//
//  ImageListBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 06.11.2022.
//

import SwiftUI

struct ImageListBottomSheet: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = ImageListMediator.shared

    var size: CGFloat = (UIScreen.main.bounds.width - 12) / 3

    var clickAction: () -> Void

    var items: [GridItem] = [
        GridItem(.fixed((UIScreen.main.bounds.width - 12) / 3), spacing: 3),
        GridItem(.fixed((UIScreen.main.bounds.width - 12) / 3), spacing: 3),
        GridItem(.fixed((UIScreen.main.bounds.width - 12) / 3), spacing: 3)]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                BackButton(style: .white) {
                    clickAction()
                }

                Spacer()
            }.padding(.init(top: 32, leading: 32, bottom: 5, trailing: 18))

            if mediator.imageList.isEmpty {
                ProgressView()
                    .tint(ColorList.white.color)
                    .padding(.init(top: 80, leading: 0, bottom: 0, trailing: 0))
                    .frame(width: 80, height: 80)
                Spacer()
            } else {
                SaveAndSetPositionScrollView(startPosition: mediator.savedPosition,
                                             offsetChanged: { mediator.savePosition($0) }) {
                    LazyVGrid(columns: items, alignment: .center, spacing: 3) {
                        ForEach(mediator.imageList, id: \.id) { item in
                            ClippedImage(item.image, size: size)
                                .onTapGesture {
                                    if mediator.imageIsSelect != nil {
                                        mediator.imageIsSelect!(item.image)
                                    }
                                    clickAction()
                                }
                        }
                    }
                }.padding(.init(top: 14, leading: 3, bottom: 45, trailing: 3))
            }

        }.onAppear {
            mediator.requestPermission = {
                store.dispatch(action: .showSetPermissionDialog)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { clickAction() }
            }
            mediator.getImages()
        }
    }
}

struct ClippedImage: View {
    let image: UIImage
    let size: CGFloat

    init(_ image: UIImage, size: CGFloat) {
        self.image = image
        self.size = size
    }
    var body: some View {
        ZStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
        }
        .cornerRadius(8)
        .frame(width: size, height: size)
    }
}
