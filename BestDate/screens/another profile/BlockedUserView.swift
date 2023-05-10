//
//  BlockedUserView.swift
//  BestDate
//
//  Created by Евгений on 12.09.2022.
//

import SwiftUI

struct BlockedUserView: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = AnotherProfileMediator.shared
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                AnotherProfileHeader(image: mediator.mainPhoto, isOnline: mediator.user.is_online ?? false, birthday: mediator.user.birthday ?? "", distance: mediator.user.getDistance()) {
                    mediator.clear = true
                } additionnallyAction: {
                    AdditionallyMediator.shared.setInfo(user: mediator.user)
                    store.dispatch(action: .showBottomSheet(view: .ANOTHER_ADDITIONALLY))
                }

                HStack(spacing: 0) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(MyColor.getColor(231, 238, 242, 0.12))
                            .background(ColorList.white_5.color)
                            .cornerRadius(16)

                        HStack(alignment: .bottom, spacing: 0) {
                            Text("\(mediator.user.getAge())")
                                .foregroundColor(ColorList.white.color)
                                .font(MyFont.getFont(.BOLD, 26))

                            Text("years_short".localized())
                                .foregroundColor(ColorList.white_80.color)
                                .font(MyFont.getFont(.BOLD, 13))
                        }.padding(.init(top: 0, leading: 6, bottom: 0, trailing: 0))
                    }.frame(width: 61, height: 58)

                    Spacer()

                    VStack(spacing: 0) {
                        HStack(spacing: 12) {
                            Text(mediator.user.name ?? "")
                                .foregroundColor(ColorList.white.color)
                                .font(MyFont.getFont(.BOLD, 26))
                                .multilineTextAlignment(.center)

                            Image((mediator.user.questionnaire?.isFull() ?? false) ? "ic_verify_active" : "ic_verify_gray")
                                .resizable()
                                .frame(width: 20, height: 20)

                        }.padding(.init(top: 0, leading: 32, bottom: 0, trailing: 0))

                        Text(mediator.user.getLocation())
                            .foregroundColor(ColorList.white_80.color)
                            .font(MyFont.getFont(.BOLD, 16))
                    }.padding(.init(top: 0, leading: 0, bottom: 0, trailing: 61))

                    Spacer()
                }
                .padding(.init(top: 24, leading: 18, bottom: 24, trailing: 18))
                .opacity(0.3)

                let topPadding = (UIScreen.main.bounds.height - (UIScreen.main.bounds.width + 321)) / 2

                Text("blacklist".localized().uppercased())
                    .foregroundColor(MyColor.getColor(142, 154, 160))
                    .font(MyFont.getFont(.NORMAL, 18))
                    .rotationEffect(Angle(degrees: -90))
                    .padding(.init(top: topPadding < 0 ? 0 : topPadding, leading: 0, bottom: 0, trailing: 0))

                HStack(spacing: 13) {
                    Image("ic_sad_emoji_blue")
                        .padding(.init(top: 12, leading: 0, bottom: 0, trailing: 0))
                    Image("ic_sad_emoji_white")
                        .padding(.init(top: 21, leading: 2, bottom: 0, trailing: 0))
                    Image("ic_sad_emoji_pink")
                }.padding(.init(top: 40, leading: 0, bottom: 0, trailing: 0))

                Text("ops_sorry".localized())
                    .foregroundColor(ColorList.white.color)
                    .font(MyFont.getFont(.BOLD, 24))
                    .padding(.init(top: 24, leading: 0, bottom: 10, trailing: 0))

                Text("you_have_been_added_to_the_backlist".localized())
                    .foregroundColor(ColorList.white_60.color)
                    .font(MyFont.getFont(.NORMAL, 18))
                    .multilineTextAlignment(.center)
            }
        }.padding(.init(top: 0, leading: 0, bottom: 80, trailing: 0))
            .edgesIgnoringSafeArea(.top)
            .background(
                Image("bg_blocked_decore")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            )
    }
}
