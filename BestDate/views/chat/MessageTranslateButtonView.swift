//
//  MessageTranslateButtonView.swift
//  BestDate
//
//  Created by Евгений on 23.04.2023.
//

import SwiftUI

struct MessageTranslateButtonView: View {
    @Binding var message: Message?

    var translateClick: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .stroke(MyColor.getColor(231, 238, 242, 0.12), lineWidth: 1)
                .background(ColorList.white_5.color)
                .cornerRadius(16)

            if getStatus() == .un_active {
                Image("ic_translate")
            } else if getStatus() == .translated {
                Image("ic_translate_active")
            } else if getStatus() == .loading {
                ProgressView()
                    .tint(ColorList.white.color)
                    .frame(width: 25, height: 25)
            }
        }.frame(width: 46, height: 46)
            .onTapGesture {
                withAnimation {
                    if getStatus() == .un_active {
                        message?.translationStatus = .loading
                        translateClick()
                    } else if getStatus() == .translated {
                        message?.translationStatus = .un_active
                        message?.translatedMessage = nil
                    }
                }
            }
    }

    private func getStatus() -> TranslateButtonStatus? {
        message?.getStatus()
    }
}

enum TranslateButtonStatus: Codable  {
    case un_active
    case loading
    case translated
}
