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

    var likeClick: (_ id: Int?) -> Void

    var size: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        ZStack {
            ForEach($users, id: \.id) { item in
                MatchImageView(match: item)
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    .opacity(getImageOpacity(id: item.wrappedValue.id))
                    .offset(x: item.wrappedValue.id > index ? size * 1.03 : 0, y: item.wrappedValue.id > index ? -(size / 4.7) : 0)
                    .rotationEffect(Angle(degrees: item.wrappedValue.id > index ? 20 : 0))
            }.padding(.init(top: 18, leading: 18, bottom: 18, trailing: 18))

            VStack {
                HStack {
                    Button(action: {
                        previousUser()
                    }) {
                        MatchButton(size: 37, icon: "ic_arrow_left_blue", opacity: 0.4)
                    }

                    Spacer()
                }.padding(.init(top: 16, leading: 16, bottom: 0, trailing: 0))

                Spacer()

                HStack {
                    Button(action: {
                        nextUser()
                    }) {
                        MatchButton(size: 65, icon: "ic_close_blue", opacity: 0.7)
                    }

                    Spacer()

                    Button(action: {
                        withAnimation { clickProcess = true }
                        likeClick(user?.id)
                        nextUser()
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

    private func nextUser() {
        if index < users.count {
            withAnimation(.easeInOut(duration: 0.5)) {
                index += 1
                if index < users.count { user = users[index].user }
                unblockButton()
            }
        }
    }

    private func previousUser() {
        if index > 0 {
            withAnimation(.easeInOut(duration: 0.5)) {
                index -= 1
                user = users[index].user
                clickProcess = false
            }
        }
    }

    private func getImageOpacity(id: Int) -> CGFloat {
        if id < index { return 0 }
        else if id > index + 1 { return 0 }
        else { return 1 }
    }

    private func unblockButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            clickProcess = false
        }
    }
}
