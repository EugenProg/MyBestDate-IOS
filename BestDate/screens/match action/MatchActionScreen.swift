//
//  MatchActionScreen.swift
//  BestDate
//
//  Created by Евгений on 28.08.2022.
//

import SwiftUI

struct MatchActionScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = MatchActionMediator.shared

    @State var visible = false
    @State var showAnimation = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(MyColor.getColor(255, 255, 255, 0.05))
                        .background(MyColor.getColor(45, 54, 59))
                        .cornerRadius(18)

                    if showAnimation {
                        LottieView(name: "match_action_anim", loopMode: .playOnce)
                    }

                    ZStack {
                        Circle()
                            .fill(ColorList.light_blue.color)
                            .blur(radius: 50)
                            .frame(width: 78, height: 78)

                        Image("bg_match_avatar")

                        AsyncImageView(url: mediator.selectedMatch?.user?.main_photo?.thumb_url)
                            .clipShape(Circle())
                            .frame(width: 41, height: 41)
                    }.padding(.init(top: 23, leading: 20, bottom: 448, trailing: UIScreen.main.bounds.width - 134))
                        .onTapGesture {
                            goToUserProfile()
                        }

                    VStack(spacing: 0) {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                HStack(spacing: 8) {
                                    Text(mediator.selectedMatch?.user?.name ?? "")
                                        .foregroundColor(ColorList.white.color)
                                        .font(MyFont.getFont(.BOLD, 16))

                                    Image((mediator.selectedMatch?.user?.full_questionnaire ?? false) ? "ic_verify_active" : "ic_verify_gray")
                                        .resizable()
                                        .frame(width: 12, height: 12)
                                }

                                Text(mediator.selectedMatch?.user?.getLocation() ?? "")
                                    .foregroundColor(ColorList.white_70.color)
                                    .font(MyFont.getFont(.NORMAL, 12))
                            }

                            Spacer()

                            DialogCloseButton {
                                store.state.showMatchActionDialog = false
                            }
                        }.padding(.init(top: 36, leading: 85, bottom: 0, trailing: 28))

                        Text("matching_you".localized().uppercased())
                            .foregroundColor(ColorList.pink.color)
                            .font(MyFont.getFont(.BOLD, 16))
                            .padding(.init(top: 38, leading: 0, bottom: 0, trailing: 0))

                        Text("congratulation".localized().uppercased())
                            .foregroundColor(MyColor.getColor(198, 222, 235))
                            .font(MyFont.getFont(.BOLD, 22))
                            .padding(.init(top: 7, leading: 0, bottom: 0, trailing: 0))

                        Spacer()

                        Text("you_have_a_match_write_to_the_user".localized())
                            .foregroundColor(MyColor.getColor(139, 160, 172))
                            .font(MyFont.getFont(.NORMAL, 16))
                            .multilineTextAlignment(.center)
                            .padding(.init(top: 0, leading: 80, bottom: 48, trailing: 80))

                        Button(action: {
                            withAnimation {
                                store.state.showMatchActionDialog = false
                                ChatMediator.shared.setUser(user: mediator.selectedMatch?.user ?? ShortUserInfo())
                                store.dispatch(action: .navigate(screen: .CHAT))
                            }
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 23)
                                    .fill(ColorList.pink.color)

                                HStack(spacing: 14) {
                                    Image("ic_chat_message")
                                        .resizable()
                                        .frame(width: 19, height: 19)

                                    Text("write_a_message".localized())
                                        .foregroundColor(ColorList.white.color)
                                        .font(MyFont.getFont(.BOLD, 18))
                                }
                            }.frame(width: 248, height: 46)
                        }.padding(.init(top: 0, leading: 0, bottom: 34, trailing: 0))
                    }

                    ZStack() {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(MyColor.getColor(255, 255, 255, 0.11))

                            UpdateImageView(image: $mediator.myPhoto)
                                .cornerRadius(8)
                                .frame(width: 51, height: 51)
                        }.frame(width: 59, height: 59)
                            .padding(.init(top: 0, leading: 91, bottom: 51, trailing: 0))

                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(MyColor.getColor(255, 255, 255, 0.11))

                            AsyncImageView(url: mediator.selectedMatch?.user?.main_photo?.thumb_url)
                                .cornerRadius(8)
                                .frame(width: 51, height: 51)
                        }.frame(width: 59, height: 59)
                            .padding(.init(top: 51, leading: 0, bottom: 0, trailing: 91))
                            .onTapGesture {
                                goToUserProfile()
                            }

                        Image("ic_matches")
                            .resizable()
                            .frame(width: 73, height: 74)
                            .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 12))
                    }.frame(width: 150, height: 110)
                        .padding(.init(top: 230, leading: 0, bottom: 208, trailing: 0))
                }
                .frame(width: UIScreen.main.bounds.width - 36, height: 549)
                .offset(y: visible ? 50 : (UIScreen.main.bounds.height - 549) / 2 + 549)
                .onTapGesture { }
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100)
        }
        .onAppear {
            withAnimation { visible = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation { showAnimation = true }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
                withAnimation { showAnimation = false }
            }
        }
    }

    private func goToUserProfile() {
        withAnimation {
            store.state.showMatchActionDialog = false
            AnotherProfileMediator.shared.setUser(user: mediator.selectedMatch?.user ?? ShortUserInfo())
            store.dispatch(action: .navigate(screen: .ANOTHER_PROFILE))
        }
    }
}

