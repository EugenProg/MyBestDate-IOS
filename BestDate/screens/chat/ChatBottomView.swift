//
//  ChatBottomView.swift
//  BestDate
//
//  Created by Евгений on 24.07.2022.
//

import SwiftUI

struct ChatBottomView: View {

    @State var text: String = ""
    var loadImageAction: () -> Void
    var translateAction: () -> Void
    var sendAction: () -> Void
    @State var additionalHeight: CGFloat = 0

    init(loadImageAction: @escaping () -> Void,
         translateAction: @escaping () -> Void,
         sendAction: @escaping () -> Void) {
        UITextView.appearance().backgroundColor = .clear
        self.loadImageAction = loadImageAction
        self.translateAction = translateAction
        self.sendAction = sendAction
    }

    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Rectangle()
                    .stroke(MyColor.getColor(255, 255, 255, 0.04), lineWidth: 1)
                    .background(MyColor.getColor(39, 47, 51))
                    .cornerRadius(radius: 33, corners: [.topLeft, .topRight])
                    .shadow(color: MyColor.getColor(17, 28, 34, 0.45), radius: 46, y: -7)

                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(MyColor.getColor(255, 255, 255, 0.06), lineWidth: 1)
                        .background(MyColor.getColor(42, 51, 55))
                        .cornerRadius(25)

                    HStack(spacing: 0) {
                        Button(action: {
                            withAnimation { loadImageAction() }
                        }) {
                            Image("ic_picture")
                                .padding(.init(top: 10, leading: 22, bottom: 10, trailing: 16))
                        }

                        Rectangle()
                            .fill(MyColor.getColor(68, 82, 87))
                            .frame(width: 1.3, height: 23 + additionalHeight)

                        ZStack(alignment: .leading) {
                        if text.isEmpty {
                            Text(NSLocalizedString("type_message", comment: "Type Message"))
                                .foregroundColor(ColorList.white_30.color)
                                .font(MyFont.getFont(.NORMAL, 18))
                                .padding(.init(top: 0, leading: 13, bottom: 0, trailing: 5))
                        }
                        TextEditor(text: $text)
                            .foregroundColor(ColorList.white.color)
                            .autocapitalization(.sentences)
                            .font(MyFont.getFont(.BOLD, 18))
                            .frame(height: 30 + additionalHeight)
                            .padding(.init(top: 9, leading: 8, bottom: 3, trailing: 5))
                            .onChange(of: text) { _ in
                                calculateSize()
                            }
                        }
                        Button(action: {
                            withAnimation { translateAction() }
                        }) {
                            Image("ic_translate")
                                .padding(.init(top: 10, leading: 8, bottom: 10, trailing: 9))
                        }

                        Button(action: {
                            withAnimation { sendAction() }
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 17)
                                    .fill(MyColor.getColor(72, 97, 105))

                                Image("ic_send")
                                    .padding(.init(top: 3, leading: 0, bottom: 0, trailing: 3))
                            }.frame(width: 33, height: 33)
                                .padding(.init(top: 8, leading: 9, bottom: 8, trailing: 11))
                        }
                    }
                }.frame(height: 50 + additionalHeight)
                .padding(.init(top: 21, leading: 18, bottom: 30, trailing: 18))
            }
            .frame(width: UIScreen.main.bounds.width, height: 101 + additionalHeight)
        }.edgesIgnoringSafeArea(.bottom)
    }

    private func calculateSize() {
        let size = self.text.boundingRect(
                    with: CGSize(
                        width: UIScreen.main.bounds.width - 185,
                        height: .greatestFiniteMagnitude
                    ),
                    options: .usesLineFragmentOrigin,
                    attributes: [.font: UIFont.systemFont(ofSize: 18)],
                    context: nil
                )
        let linesCount = Int(size.height / 21.48)
        if linesCount <= 3 {
            withAnimation {
                additionalHeight = CGFloat((linesCount - 1) * 21)
            }
        } else {
            withAnimation {
                additionalHeight = CGFloat(42)
            }
        }
    }
}
