//
//  AnotherProfileImagesScreen.swift
//  BestDate
//
//  Created by Евгений on 06.08.2022.
//

import SwiftUI

struct AnotherProfileImagesScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = AnotherProfileMediator.shared
    @State var isLiked: Bool = false

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    BackButton(style: .white)

                    Spacer()
                }.frame(width: UIScreen.main.bounds.width - 50, height: 60)
                    .padding(.init(top: 16, leading: 32, bottom: 0, trailing: 18))

                Spacer()

                ImagesListView(images: $mediator.imageList, selectedImage: $mediator.selectedImage) {
                    isLiked = mediator.imageList[mediator.selectedImage].liked == true
                } closeAction: {
                    store.dispatch(action: .navigationBack)
                }

                Spacer()
            }

            AnotherProfileNavigationPanelView(isLiked: $isLiked, opacity: false) {
                ChatMediator.shared.setUser(user: mediator.user)
                store.dispatch(action: .navigate(screen: .CHAT))
            } likeClick: {
                mediator.likePhoto(id: mediator.imageList[mediator.selectedImage].id ?? 0) { }
            } createClick: {
                CreateInvitationMediator.shared.setUser(user: mediator.user.toShortUser())
                store.dispatch(action: .createInvitation)
            }.zIndex(15)

        }.frame(width: UIScreen.main.bounds.width)
            .background(MyColor.getColor(23, 28, 31).edgesIgnoringSafeArea(.bottom))
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: MyColor.getColor(23, 28, 31), style: .lightContent))
                isLiked = mediator.imageList.isEmpty ? false : (mediator.imageList[mediator.selectedImage].liked ?? false)
            }
    }
}

struct AnotherProfileImagesScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnotherProfileImagesScreen()
    }
}
