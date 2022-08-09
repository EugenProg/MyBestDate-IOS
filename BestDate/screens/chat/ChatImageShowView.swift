//
//  ChatImageShowView.swift
//  BestDate
//
//  Created by Евгений on 09.08.2022.
//

import SwiftUI

struct ChatImageShowView: View {
    @Binding var message: Message?
    @Binding var show: Bool

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    BackButton(style: .white) {
                        show = false
                    }

                    Spacer()
                }.frame(width: UIScreen.main.bounds.width - 64, height: 60)
                    .padding(.init(top: 16, leading: 32, bottom: 0, trailing: 32))

                Spacer()
            }

            VStack {
                ChatImageView(message: $message, smallUrl: false)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width)
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(ColorList.main.color)
            .onTapGesture {
                withAnimation { show = false }
            }
    }
}

