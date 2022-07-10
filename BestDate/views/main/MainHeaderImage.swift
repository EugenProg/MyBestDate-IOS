//
//  MainHeaderImage.swift
//  BestDate
//
//  Created by Евгений on 10.07.2022.
//

import SwiftUI

struct MainHeaderImage: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = MainMediator.shared

    var body: some View {
        ZStack {
            Image("ic_button_decor")
                .padding(.init(top: 7, leading: 33, bottom: 0, trailing: 0))

            HStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(ColorList.main.color)
                        .shadow(color: MyColor.getColor(17, 24, 28, 0.6), radius: 16, y: 3)
                        .frame(width: 50, height: 50)

                    AsyncImageView(url: mediator.mainPhoto?.thumb_url)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 44, height: 44, alignment: .center)
                }.zIndex(100)

                Image("ic_arrow_right_blue")
                    .padding(.init(top: 0, leading: 5, bottom: 0, trailing: 0))
            }

            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(ColorList.main.color)
                        .frame(width: 14, height: 14)

                    RoundedRectangle(cornerRadius: 5)
                        .fill(ColorList.pink.color)
                        .frame(width: 10, height: 10)
                }
                .padding(.init(top: 5, leading: 5, bottom: 0, trailing: 0))
            }.frame(width: 77, height: 60, alignment: .topLeading)
        }.frame(width: 77, height: 60)
    }
}

struct MainHeaderImage_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderImage()
    }
}
