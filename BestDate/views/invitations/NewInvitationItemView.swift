//
//  NewInvitationItemView.swift
//  BestDate
//
//  Created by Евгений on 21.08.2022.
//

import SwiftUI

struct NewInvitationItemView: View {
    var invitationCard: InvitationCard

    var answerAction: (_ text: String) -> Void
    var userSelectAction: (_ user: ShortUserInfo?) -> Void

    @State var frontSide: Bool = true

    fileprivate func frontSideView() -> some View {
        ZStack {
            Image("bg_invitation_card")
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 36, height: 174)

            ZStack(alignment: .topTrailing) {
                Image("ic_invitation_title")
                    .opacity(0.35)
            }.frame(width: UIScreen.main.bounds.width - 72, height: 138, alignment: .topTrailing)

            Image("ic_invitation_decor")

            VStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 6) {
                    Image("ic_add")

                    VStack(alignment: .leading, spacing: 3) {
                        Text(invitationCard.invitation?.name ?? "Sex")
                            .foregroundColor(ColorList.main.color)
                            .font(MyFont.getFont(.BOLD, 26))

                        Text(NSLocalizedString("you_have_received_an_invitation_please_give_an_answer", comment: "answer please"))
                            .foregroundColor(ColorList.main_60.color)
                            .font(MyFont.getFont(.NORMAL, 13))
                    }
                }
                .padding(.init(top: 18, leading: 36, bottom: 18, trailing: 36))

                Spacer()

                HStack(alignment: .bottom) {
                    HStack(spacing: 7) {
                        AsyncImageView(url: invitationCard.from_user?.main_photo?.thumb_url)
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 26, height: 26)

                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 7) {
                                Text(invitationCard.from_user?.name ?? "Noname")
                                    .foregroundColor(ColorList.main_70.color)
                                    .font(MyFont.getFont(.BOLD, 14))

                                Image((invitationCard.from_user?.full_questionnaire ?? false) ? "ic_verify_active" : "ic_verify_gray")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                            }
                            Text(invitationCard.from_user?.getLocation() ?? "")
                                .foregroundColor(ColorList.main_50.color)
                                .font(MyFont.getFont(.NORMAL, 11))
                        }
                    }.onTapGesture {
                        withAnimation { userSelectAction(invitationCard.from_user) }
                    }

                    Spacer()

                    cardButton(text: "answer_choice") {
                        withAnimation { frontSide.toggle() }
                    }
                }.padding(.init(top: 0, leading: 36, bottom: 16, trailing: 36))
            }
        }
    }

    fileprivate func backSideView() -> some View {
        ZStack {
            Image("bg_invitation_card")
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 36, height: 174)

            VStack {
                HStack(spacing: 8) {
                    cardButton(text: "yes_i_agree") {
                        answerAction(NSLocalizedString("yes", comment: "text"))
                    }

                    cardButton(text: "yes_i_will_but_next_time") {
                        answerAction(NSLocalizedString("yes later", comment: "text"))
                    }
                }

                Spacer()

                HStack(spacing: 8) {
                    cardButton(text: "thanks_but_i_cant_yet") {
                        answerAction(NSLocalizedString("not yet", comment: "text"))
                    }

                    cardButton(text: "no") {
                        answerAction(NSLocalizedString("no", comment: "text"))
                    }
                }
            }.padding(.init(top: 32, leading: 16, bottom: 24, trailing: 16))
        }.rotation3DEffect(Angle(degrees: -180), axis: (x: 0, y: 1, z: 0))
    }

    fileprivate func cardButton(text: String, clickAction: @escaping () -> Void) -> some View {
        Button(action: {
            withAnimation { clickAction() }
        }) {
            Text(NSLocalizedString(text, comment: "text"))
                .foregroundColor(ColorList.white.color)
                .font(MyFont.getFont(.BOLD, 14))
                .padding(.init(top: 7, leading: 22, bottom: 6, trailing: 22))
                .frame(minWidth: UIScreen.main.bounds.width / 3.8)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(ColorList.main.color)
                )
        }
        .padding(8)
    }

    var body: some View {
        ZStack {
            if frontSide {
                frontSideView()
            } else {
                backSideView()
            }
        }
        .rotation3DEffect(Angle(degrees: frontSide ? 0 : 180), axis: (x: 0, y: 1, z: 0))
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.4)) { frontSide.toggle() }
        }
    }
}
