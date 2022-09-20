//
//  MatchSliderView.swift
//  BestDate
//
//  Created by Евгений on 10.08.2022.
//

import SwiftUI

struct MatchSliderView: View {
    @Binding var users: [MatchItem]
    @Binding var user: ShortUserInfo?
    @Binding var index: Int

    @State var clickProcess: Bool = false

    var openProfile: (ShortUserInfo?) -> Void
    var likeClick: (_ id: Int?) -> Void

    var size: CGFloat = UIScreen.main.bounds.width
    @GestureState private var offsetState = CGSize.zero

    var body: some View {
        ZStack {
            ForEach($users, id: \.id) { item in
                MatchImageView(match: item)
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    .opacity(getImageOpacity(id: item.wrappedValue.id))
                    .offset(item.wrappedValue.offset)
                    .rotationEffect(item.wrappedValue.rotation)
                    .gesture(dragGesture)
                    .onTapGesture {
                        withAnimation { openProfile(user) }
                    }
            }.padding(.init(top: 18, leading: 18, bottom: 18, trailing: 18))

            VStack {
                Spacer()

                HStack {
                    Button(action: {
                        nextUser(liked: false)
                    }) {
                        MatchButton(size: 65, icon: "ic_close_blue", opacity: 0.7)
                    }

                    Spacer()

                    Button(action: {
                        nextUser(liked: true)
                    }) {
                        MatchButton(size: 65, icon: "ic_heart", opacity: 0.7)
                    }
                }.padding(.init(top: 0, leading: 16, bottom: 16, trailing: 16))
            }.padding(.init(top: 18, leading: 18, bottom: 18, trailing: 18))

            if clickProcess {
                LottieView(name: "love_burst_pink", loopMode: .playOnce)
                    .frame(width: 130, height: 130)
                    .padding(.init(top: size - 130, leading: size - 130, bottom: 0, trailing: 0))
            }
        }.frame(width: size, height: size)
    }

    fileprivate func MatchButton(size: CGFloat, icon: String, opacity: CGFloat) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: size / 2)
                .stroke(MyColor.getColor(190, 239, 255, 0.15), lineWidth: 1)
                .background(ColorList.main.color)
                .cornerRadius(size / 2)
                .shadow(color: MyColor.getColor(28, 35, 39, 0.63), radius: 46, y: 23)
                .opacity(opacity)

            Image(icon)
        }.frame(width: size, height: size)
    }

    private func nextUser(liked: Bool) {
        if index < users.count {
            withAnimation(.easeInOut(duration: 0.5)) {
                index += 1
                if liked { likeClick(user?.id) }
                if index < users.count {
                    user = users[index].user
                }
                clickProcess = liked
                modify(liked: liked)
                unblockButton()
            }
        }
    }

    private func getImageOpacity(id: Int) -> CGFloat {
        if id == index - 1 { return 1 }
        else if id == index { return 1 }
        else { return 0 }
    }

    private func modify(liked: Bool) {
        users[index - 1].offset = CGSize(width: liked ? size * 1.1 : -(size * 1.1), height: -(size / 4.7))
        users[index - 1].rotation = Angle(degrees: liked ? 20 : -20)
    }

    private func unblockButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            clickProcess = false
        }
    }

    var dragGesture: some Gesture {
        DragGesture()
            .updating($offsetState) { currentState, gestureState, _ in
                gestureState = currentState.translation
                if index < users.count {
                    users[index].offset = offsetState
                }
            }.onEnded { value in
                if value.translation.width > 50 {
                    withAnimation { clickProcess = true }
                    nextUser(liked: true)
                } else if value.translation.width < -50 {
                    nextUser(liked: false)
                }
            }
    }
}
