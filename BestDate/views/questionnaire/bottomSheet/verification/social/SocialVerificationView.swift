//
//  SocialVerificationView.swift
//  BestDate
//
//  Created by Евгений on 17.08.2022.
//

import SwiftUI

struct SocialVerificationView: View {

    @ObservedObject var mediator = VerificationMediator.shared

    @State var instaConfirmed: Bool = false
    @State var faceConfirmed: Bool = false
    @State var twitConfirmed: Bool = false
    @State var linkConfirmed: Bool = false

    @State var phoneError: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            VerificationInputView(image: SocialTypes.insta.image, hint: "insta", input: $mediator.instaInput,
                                  isConfimed: $instaConfirmed, errorState: $mediator.instaError) { link in
                instaConfirmed = SocialTypes.getSocialTypeByLink(link: link) == .insta
                }.padding(.init(top: 0, leading: 32, bottom: 0, trailing: 32))

            VerificationInputView(image: SocialTypes.facebook.image, hint: "facebook", input: $mediator.faceInput,
                                  isConfimed: $faceConfirmed, errorState: $mediator.faceError) { link in
                faceConfirmed = SocialTypes.getSocialTypeByLink(link: link) == .facebook
            }.padding(.init(top: 0, leading: 32, bottom: 0, trailing: 32))

            VerificationInputView(image: SocialTypes.twitter.image, hint: "twitter", input: $mediator.twitInput,
                                  isConfimed: $twitConfirmed, errorState: $mediator.twitError) { link in
                twitConfirmed = SocialTypes.getSocialTypeByLink(link: link) == .twitter
            }.padding(.init(top: 0, leading: 32, bottom: 0, trailing: 32))

            VerificationInputView(image: SocialTypes.linkedin.image, hint: "linkedin", input: $mediator.linkInput,
                                  isConfimed: $linkConfirmed, errorState: $mediator.linkError) { link in
                linkConfirmed = SocialTypes.getSocialTypeByLink(link: link) == .linkedin
            }.padding(.init(top: 0, leading: 32, bottom: 0, trailing: 32))
        }
        .onAppear {
            mediator.instaInput = getLinkByType(type: .insta)
            mediator.faceInput = getLinkByType(type: .facebook)
            mediator.twitInput = getLinkByType(type: .twitter)
            mediator.linkInput = getLinkByType(type: .linkedin)

            instaConfirmed = SocialTypes.getSocialTypeByLink(link: mediator.instaInput) == .insta
            faceConfirmed = SocialTypes.getSocialTypeByLink(link: mediator.faceInput) == .facebook
            twitConfirmed = SocialTypes.getSocialTypeByLink(link: mediator.twitInput) == .twitter
            linkConfirmed = SocialTypes.getSocialTypeByLink(link: mediator.linkInput) == .linkedin
        }
    }

    private func getLinkByType(type: SocialTypes) -> String {
        mediator.socialNetworkes.first(where: { net in
            net.type == type
        })?.link ?? ""
    }
}
