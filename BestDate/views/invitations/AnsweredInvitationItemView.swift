//
//  AnsweredInvitationItemView.swift
//  BestDate
//
//  Created by Евгений on 21.08.2022.
//

import SwiftUI

struct AnsweredInvitationItemView: View {
    var invitationCard: InvitationCard
    
    var userSelectAction: (_ user: ShortUserInfo?) -> Void

    let width = UIScreen.main.bounds.width - 36

    var body: some View {
        ZStack {
            Image("bg_invitation_card")
                .resizable()
                .frame(width: width, height: 174)
            
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
                        
                        Text(NSLocalizedString("we_have_transmitted_your_reply_to_the_sender", comment: "answer please"))
                            .foregroundColor(ColorList.main_60.color)
                            .font(MyFont.getFont(.NORMAL, 13))
                    }
                }
                .padding(.init(top: 18, leading: 36, bottom: 18, trailing: 36))
                
                Spacer()
                
                HStack {
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
                    
                }.padding(.init(top: 0, leading: 36, bottom: 16, trailing: 36))
            }

            HStack() {
                Spacer()
                VStack(spacing: 11) {
                    if invitationCard.status == true {
                        SuccessItemView()
                    } else if invitationCard.status == false {
                        CloseItemView()
                    }

                    Text(invitationCard.status == true ? "Yes I agree" : "Thanks, but I can’t yet")
                        .foregroundColor(ColorList.main.color)
                        .font(MyFont.getFont(.BOLD, 14))
                }.frame(width: width / 2, height: 130, alignment: .bottom)
                    .padding(.init(top: 0, leading: 20, bottom: 5, trailing: 0))
            }.frame(width: width, height: 174)
        }
    }
}
