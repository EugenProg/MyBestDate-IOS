//
//  ActiveUserView.swift
//  BestDate
//
//  Created by Евгений on 12.09.2022.
//

import SwiftUI

struct ActiveUserView: View {
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
                .padding(.init(top: 8, leading: 18, bottom: 8, trailing: 18))

                AnotherProfileImageLineView(imagesList: $mediator.imageList, imagesCount: $mediator.photoCount) { index in
                    goToImageViewer(index: index)
                }
                .padding(.init(top: 0, leading: 0, bottom: 100, trailing: 0))
            }
        }.padding(.init(top: 0, leading: 0, bottom: 80, trailing: 0))
            .edgesIgnoringSafeArea(.top)
    }

    private func goToImageViewer(index: Int) {
        if !mediator.imageList.isEmpty {
            withAnimation {
                mediator.selectedImage = index
                store.dispatch(action: .navigate(screen: .ANOTHER_IMAGES))
            }
        }
    }
}
