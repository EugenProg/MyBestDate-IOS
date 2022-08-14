//
//  ChatImageViewer.swift
//  BestDate
//
//  Created by Евгений on 08.08.2022.
//

import SwiftUI

struct ChatImageViewer: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = ChatMediator.shared
    @State private var offsetValue: CGFloat = 0.0

    @State var additionalHeight: CGFloat = 0
    @State var text: String = ""
    @State var sendTextProcess: Bool = false
    @State var translateProcess: Bool = false

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    BackButton(style: .white) {
                        mediator.selectedImage = nil
                        mediator.editImageMode = false
                    }

                    Spacer()
                }

                Title(textColor: ColorList.white.color, text: mediator.user.name ?? "", textSize: 20, paddingV: 0, paddingH: 0)
            }.frame(width: UIScreen.main.bounds.width - 64, height: 60)
                .padding(.init(top: 16, leading: 32, bottom: 0, trailing: 32))

            Spacer()

            Image(uiImage: mediator.selectedImage ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width)

            Spacer()

            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(MyColor.getColor(255, 255, 255, 0.06), lineWidth: 1)
                    .background(MyColor.getColor(42, 51, 55))
                    .cornerRadius(25)

                HStack(spacing: 0) {
                    ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(NSLocalizedString("add_a_caption", comment: "Type Message"))
                            .foregroundColor(ColorList.white_30.color)
                            .font(MyFont.getFont(.NORMAL, 18))
                            .padding(.init(top: 0, leading: 23, bottom: 0, trailing: 5))
                    }
                    TextEditor(text: $text)
                        .foregroundColor(ColorList.white.color)
                        .autocapitalization(.sentences)
                        .font(MyFont.getFont(.BOLD, 18))
                        .frame(height: 40 + additionalHeight)
                        .padding(.init(top: 9, leading: 18, bottom: 8, trailing: 3))
                        .onChange(of: text) { _ in
                            calculateSize()
                        }
                    }
                    Button(action: {
                        if !text.isEmpty && !translateProcess && !sendTextProcess {
                            withAnimation {
                                translateProcess.toggle()
                                //translateAction(text)
                            }
                        }
                    }) {
                        if translateProcess {
                            ProgressView()
                                .tint(ColorList.white.color)
                                .frame(width: 25, height: 25)
                                .padding(.init(top: 10, leading: 6, bottom: 10, trailing: 7))
                        } else {
                            Image("ic_translate")
                                .padding(.init(top: 10, leading: 8, bottom: 10, trailing: 9))
                        }
                    }

                    Button(action: {
                        if !sendTextProcess && !translateProcess {
                            withAnimation {
                                sendTextProcess.toggle()
                                send()
                            }
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 17)
                                .fill(MyColor.getColor(72, 97, 105))

                            if sendTextProcess {
                                ProgressView()
                                    .tint(ColorList.white.color)
                                    .frame(width: 25, height: 25)
                            } else {
                                Image("ic_send")
                                    .padding(.init(top: 3, leading: 0, bottom: 0, trailing: 3))
                            }
                        }.frame(width: 33, height: 33)
                            .padding(.init(top: 8, leading: 9, bottom: 8, trailing: 11))
                    }
                }
                .keyboardSensible($offsetValue)
            }.frame(height: 50 + additionalHeight)
                .padding(.init(top: 16, leading: 18, bottom: store.state.statusBarHeight + 32, trailing: 18))
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(ColorList.main.color)
    }

    private func send() {
        mediator.sendImageMessage(
            image: mediator.selectedImage ?? UIImage(),
            message: text.isEmpty ? nil : text) { success in
                DispatchQueue.main.async {
                    withAnimation {
                        sendTextProcess = false
                        text = ""
                        mediator.selectedImage = nil
                        mediator.editImageMode = false
                    }
                }

            }
    }

    private func calculateSize() {
        let size = self.text.getLinesHeight(viewVidth: UIScreen.main.bounds.width - 131, fontSize: 18)

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
