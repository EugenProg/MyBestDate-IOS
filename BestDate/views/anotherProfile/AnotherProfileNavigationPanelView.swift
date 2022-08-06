//
//  AnotherProfileNavigationPanelView.swift
//  BestDate
//
//  Created by Евгений on 17.07.2022.
//

import SwiftUI

struct AnotherProfileNavigationPanelView: View {
    @EnvironmentObject var store: Store
    @Binding var isLiked: Bool
    @State var showProcess: Bool = false

    var messageClick: () -> Void
    var likeClick: () -> Void
    var createClick: () -> Void

    fileprivate func buttonContent(bg: String, image: String, size: CGFloat) -> some View {
        ZStack {
            Image(bg)

            RoundedRectangle(cornerRadius: 28)
                .stroke(MyColor.getColor(190, 239, 255, 0.18), lineWidth: 1)
                .background(ColorList.main.color)
                .cornerRadius(28)
                .shadow(color: MyColor.getColor(80, 110, 126, 0.63), radius: 46, y: 23)
                .frame(width: size, height: size)

            Image(image)
        }
    }
    
    var body: some View {
        VStack {
            Spacer()

            ZStack {
                VStack {
                    Spacer()
                    Image("ic_nav_panel_bg")
                }.edgesIgnoringSafeArea(.bottom)

                VStack {
                    Spacer()
                    HStack(alignment: .bottom, spacing: 17) {
                        Button(action: {
                            withAnimation { messageClick() }
                        }) {
                            buttonContent(bg: "ic_button_bg_small", image: "ic_chat_message", size: 62)
                        }

                        Button(action: {
                            withAnimation { createClick() }
                        }) {
                            buttonContent(bg: "ic_button_bg_large", image: "ic_add", size: 70)
                                .padding(.init(top: 0, leading: 0, bottom: 2, trailing: 0))
                        }

                        Button(action: {
                            if !isLiked {
                                withAnimation {
                                    likeClick()
                                    showProcess = true
                                }
                            }
                        }) {
                            buttonContent(bg: "ic_button_bg_small", image: isLiked ? "ic_is_liked" : "ic_like", size: 62)
                        }
                    }.padding(.init(top: 0, leading: 0, bottom: 30, trailing: 0))
                }
                    .edgesIgnoringSafeArea(.bottom)

                if showProcess {
                    let leftPadding = (UIScreen.main.bounds.width / 2) + 43
                    let rightPadding = UIScreen.main.bounds.width - 130 - leftPadding
                    LottieView(name: "love_burst_pink", loopMode: .playOnce)
                        .frame(width: 130, height: 130)
                        .padding(.init(top: 35, leading: leftPadding, bottom: 0, trailing: rightPadding))
                }
            }.frame(width: UIScreen.main.bounds.width, height: 130)
                .background(ColorList.main_90.color)
                .padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight, trailing: 0))
        }
    }
}
