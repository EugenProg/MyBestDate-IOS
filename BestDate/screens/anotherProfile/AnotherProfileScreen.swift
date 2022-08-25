//
//  OtherProfileScreen.swift
//  BestDate
//
//  Created by Евгений on 17.07.2022.
//

import SwiftUI

struct AnotherProfileScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = AnotherProfileMediator.shared

    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    AnotherProfileHeader(image: mediator.mainPhoto, isOnline: mediator.user.is_online ?? false, birthday: mediator.user.birthday ?? "", distance: mediator.user.getDistance()) {
                        mediator.cleanUserData()
                    } additionnallyAction: {
                        AdditionallyMediator.shared.setInfo(user: mediator.user)
                        store.dispatch(action: .showBottomSheet(view: .ANOTHER_ADDITIONALLY))
                    }.onTapGesture {
                        goToImageViewer(index: mediator.getMainPhotoIndex())
                    }

                    DirrectionLineButtonView(name: "questionnaire", icon: "ic_document", buttonColor: ColorList.pink_5.color) {
                        AnotherProfileQuestionnaireMediator.shared.setUser(user: mediator.user)
                        store.dispatch(action: .navigate(screen: .ANOTHER_QUESTIONNAIRE))
                    }.padding(.init(top: 3, leading: 0, bottom: 0, trailing: 0))

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

                                Text("y")
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

                    AnotherProfileImageLineView(imagesList: $mediator.imageList) { index in
                        goToImageViewer(index: index)
                    }
                    .padding(.init(top: 0, leading: 0, bottom: 100, trailing: 0))
                }
            }.padding(.init(top: 0, leading: 0, bottom: 80, trailing: 0))
                .edgesIgnoringSafeArea(.top)

            AnotherProfileNavigationPanelView(isLiked: $mediator.mainLiked) {
                ChatMediator.shared.setUser(user: mediator.user)
                store.dispatch(action: .navigate(screen: .CHAT))
            } likeClick: {
                mediator.likePhoto(id: mediator.mainPhoto.id) { }
            } createClick: {
                CreateInvitationMediator.shared.setUser(user: mediator.user.toShortUser())
                store.dispatch(action: .createInvitation)
            }.zIndex(15)

        }.frame(width: UIScreen.main.bounds.width)
            .background(ColorList.main.color.edgesIgnoringSafeArea(.all))
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.main.color, style: .lightContent))
            }
    }

    private func goToImageViewer(index: Int) {
        withAnimation {
            mediator.selectedImage = index
            store.dispatch(action: .navigate(screen: .ANOTHER_IMAGES))
        }
    }
}

