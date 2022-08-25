//
//  SendedInvitationItemView.swift
//  BestDate
//
//  Created by Евгений on 21.08.2022.
//

import SwiftUI

struct SendedInvitationItemView: View {
    var invitation: InvitationCard

    var userSelectAction: (_ user: ShortUserInfo?) -> Void

    var body: some View {
        ZStack {
            Image("bg_invitation_card")
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 36, height: 174)

            ZStack(alignment: .topTrailing) {
                Image("ic_invitation_title")
                    .opacity(0.35)
            }.frame(width: UIScreen.main.bounds.width - 72, height: 138, alignment: .topTrailing)

            Image("ic_invitation_decor")

            VStack(alignment: .leading, spacing: 6) {
                Text(NSLocalizedString("you_invited", comment: "Title"))
                    .foregroundColor(ColorList.main_60.color)
                    .font(MyFont.getFont(.NORMAL, 13))

                Text(invitation.from_user?.name ?? "")
                    .foregroundColor(ColorList.main.color)
                    .font(MyFont.getFont(.BOLD, 26))

                HStack {
                    HStack(spacing: 7) {
                        AsyncImageView(url: invitation.from_user?.main_photo?.thumb_url)
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 26, height: 26)

                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 7) {
                                Text(invitation.from_user?.name ?? "Noname")
                                    .foregroundColor(ColorList.main_70.color)
                                    .font(MyFont.getFont(.BOLD, 14))

                                Image((invitation.from_user?.full_questionnaire ?? false) ? "ic_verify_active" : "ic_verify_gray")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                            }
                            Text(invitation.from_user?.getLocation() ?? "")
                                .foregroundColor(ColorList.main_50.color)
                                .font(MyFont.getFont(.NORMAL, 11))
                        }
                    }.onTapGesture {
                        withAnimation { userSelectAction(invitation.from_user) }
                    }
                }.padding(.init(top: 3, leading: 0, bottom: 0, trailing: 0))

                Rectangle()
                    .fill(ColorList.main_20.color)
                    .frame(width: UIScreen.main.bounds.width - 72, height: 1)
                    .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))

                Text("\(invitation.from_user?.name ?? "") hasn’t given an answer yet")
                    .foregroundColor(ColorList.main.color)
                    .font(MyFont.getFont(.BOLD, 14))

            }.frame(width: UIScreen.main.bounds.width - 72, height: 140, alignment: .leading)
        }
    }
}
