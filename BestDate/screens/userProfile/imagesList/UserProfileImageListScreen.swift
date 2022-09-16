//
//  UserProfileImageListScreen.swift
//  BestDate
//
//  Created by Евгений on 24.08.2022.
//

import SwiftUI

struct UserProfileImageListScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = ProfileMediator.shared
    @State var showButtons = true

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    BackButton(style: .white)

                    Spacer()
                }.frame(width: UIScreen.main.bounds.width - 50, height: 60)
                    .padding(.init(top: 16, leading: 32, bottom: 0, trailing: 18))

                Spacer()

                ImagesListView(images: $mediator.profileImages, selectedImage: $mediator.selectedImage, showButtons: $showButtons) { }

                Spacer()
            }

        }.frame(width: UIScreen.main.bounds.width)
            .background(MyColor.getColor(23, 28, 31))
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: MyColor.getColor(23, 28, 31), style: .lightContent))

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation { showButtons = false }
                }
            }
    }
}

struct UserProfileImageListScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileImageListScreen()
    }
}
