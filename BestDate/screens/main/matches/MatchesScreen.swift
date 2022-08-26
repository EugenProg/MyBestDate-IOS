//
//  MatchesScreen.swift
//  BestDate
//
//  Created by Евгений on 07.07.2022.
//

import SwiftUI

struct MatchesScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = MatchMediator.shared
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            ProfileMediator.shared.setUser(user: MainMediator.shared.user)
                            store.dispatch(action: .navigate(screen: .PROFILE))
                        }
                    }) {
                        MainHeaderImage()
                    }

                    Spacer()

                    ProfileButtonView(image: "ic_matches", isActive: true, size: CGSize(width: 48, height: 46)) {
                        //store.dispatch(action: .navigate(screen: .MATCHES_LIST))
                    }
                }

                Title(textColor: ColorList.white.color, text: "matches", textSize: 20, paddingV: 0, paddingH: 0)
            }.frame(width: UIScreen.main.bounds.width - 64, height: 60)
                .padding(.init(top: 16, leading: 0, bottom: 16, trailing: 0))

            Rectangle()
                .fill(MyColor.getColor(190, 239, 255, 0.15))
                .frame(height: 1)

            if !mediator.users.isEmpty && mediator.currentIndex < mediator.users.count {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        MatchSliderView(users: $mediator.users,
                                        user: $mediator.currentUser,
                                        index: $mediator.currentIndex,
                                        openProfile: openProfile()) { id in
                            mediator.matchAction(id: id)
                        }.padding(.init(top: 18, leading: 0, bottom: 21, trailing: 0))

                        HStack(spacing: 0) {
                            Text(mediator.currentUser?.name ?? "")
                                .foregroundColor(ColorList.white.color)
                                .font(MyFont.getFont(.BOLD, 22))

                            Image((mediator.currentUser?.full_questionnaire ?? false) ? "ic_verify_active" : "ic_verify_gray")
                                .resizable()
                                .frame(width: 14, height: 14)
                                .padding(.init(top: 0, leading: 7, bottom: 0, trailing: 14))

                            Text("\(mediator.currentUser?.getAge() ?? 18)")
                                .foregroundColor(ColorList.white_80.color)
                                .font(MyFont.getFont(.BOLD, 19))

                            Text("y")
                                .foregroundColor(ColorList.white_80.color)
                                .font(MyFont.getFont(.BOLD, 12))
                                .padding(.init(top: 0, leading: 3, bottom: 0, trailing: 0))

                            Spacer()

                            if mediator.currentUser?.is_online ?? false {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(ColorList.green.color)
                                    .frame(width: 12, height: 12)
                            }

                            Text(mediator.currentUser?.getDistance() ?? "")
                                .foregroundColor(ColorList.white.color)
                                .font(MyFont.getFont(.NORMAL, 14))
                                .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 0))
                        }.padding(.init(top: 0, leading: 32, bottom: 0, trailing: 32))

                        HStack(spacing: 0) {
                            Text(mediator.currentUser?.getLocation() ?? "")
                                .foregroundColor(ColorList.white_40.color)
                                .font(MyFont.getFont(.NORMAL, 14))

                            Spacer()
                        }.padding(.init(top: 2, leading: 32, bottom: 0, trailing: 32))

                        DirrectionLineButtonView(name: "questionnaire", icon: "ic_document", buttonColor: ColorList.pink_5.color) {
                            AnotherProfileQuestionnaireMediator.shared.setUser(user: mediator.currentUser)
                            store.dispatch(action: .navigate(screen: .ANOTHER_QUESTIONNAIRE))
                        }
                    }
                }
            } else {
                NoDataBoxView(text: "sorry_you_voted_for_all_the_photos")
                    .padding(.init(top: 50, leading: 50, bottom: ((UIScreen.main.bounds.width - 9) / 2) - 69, trailing: 50))

                Spacer()
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
        .onAppear {
            if mediator.users.isEmpty {
                mediator.getNextMatchPage()
            }
        }
    }

    private func openProfile() -> (ShortUserInfo?) -> Void {
        { user in
            AnotherProfileMediator.shared.setUser(user: user ?? ShortUserInfo())
            store.dispatch(action: .navigate(screen: .ANOTHER_PROFILE))
        }
    }
}

struct MatchesScreen_Previews: PreviewProvider {
    static var previews: some View {
        MatchesScreen()
    }
}
