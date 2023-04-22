//
//  ChatBottomView.swift
//  BestDate
//
//  Created by Евгений on 24.07.2022.
//

import SwiftUI

struct ChatBottomView: View {

    @Binding var text: String
    @Binding var sendTextProcess: Bool
    @Binding var translateProcess: Bool
    var loadImageAction: () -> Void
    var translateAction: (String) -> Void
    var sendAction: (String) -> Void
    @Binding var additionalHeight: CGFloat
    @Binding var editMode: Bool
    @Binding var replyMode: Bool
    @Binding var selectedMessage: Message?

    init(text: Binding<String>,
         sendTextProcess: Binding<Bool>,
         translateProcess: Binding<Bool>,
         additionalHeight: Binding<CGFloat>,
         editMode: Binding<Bool>,
         replyMode: Binding<Bool>,
         selectedMessage: Binding<Message?>,
         loadImageAction: @escaping () -> Void,
         translateAction: @escaping (String) -> Void,
         sendAction: @escaping (String) -> Void) {
        UITextView.appearance().backgroundColor = .clear
        self._text = text
        self.loadImageAction = loadImageAction
        self.translateAction = translateAction
        self.sendAction = sendAction
        self._sendTextProcess = sendTextProcess
        self._translateProcess = translateProcess
        self._additionalHeight = additionalHeight
        self._editMode = editMode
        self._replyMode = replyMode
        self._selectedMessage = selectedMessage
    }

    var body: some View {
            ZStack(alignment: .bottom) {
                if editMode || replyMode {
                    Rectangle()
                        .stroke(MyColor.getColor(255, 255, 255, 0.04), lineWidth: 1)
                        .background(MyColor.getColor(39, 47, 51))
                        .shadow(color: MyColor.getColor(17, 28, 34, 0.45), radius: 46, y: -7)

                    HStack(spacing: 0) {
                        Image(editMode ? "ic_edit" : "ic_reply_white")
                            .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 11))

                        if selectedMessage?.image != nil {
                            ChatImageView(message: $selectedMessage)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .frame(width: 35, height: 35)
                                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 11))
                        }

                        Text(selectedMessage?.text ?? "")
                            .foregroundColor(ColorList.white_70.color)
                            .font(MyFont.getFont(.NORMAL, 18))

                        Spacer()

                        Button(action: {
                            if editMode { withAnimation {
                                editMode = false
                                text = ""
                            } }
                            if replyMode { withAnimation { replyMode = false } }
                            selectedMessage = nil
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(MyColor.getColor(51, 62, 67))

                                Image("ic_close_white")
                            }.frame(width: 23, height: 23)
                        }
                    }.frame(height: 23)
                        .padding(.init(top: 10, leading: 18, bottom: 113 + additionalHeight, trailing: 18))
                }
                
                Rectangle()
                    .stroke(MyColor.getColor(255, 255, 255, 0.04), lineWidth: 1)
                    .background(MyColor.getColor(39, 47, 51))
                    .cornerRadius(radius: 33, corners: [.topLeft, .topRight])
                    .shadow(color: MyColor.getColor(17, 28, 34, 0.45), radius: 46, y: -7)
                    .frame(width: UIScreen.main.bounds.width, height: 101 + additionalHeight)

                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(MyColor.getColor(255, 255, 255, 0.06), lineWidth: 1)
                        .background(MyColor.getColor(42, 51, 55))
                        .cornerRadius(25)

                    HStack(spacing: 0) {
                        Button(action: {
                            if !translateProcess && !sendTextProcess {
                                withAnimation { loadImageAction() }
                            }
                        }) {
                            Image("ic_picture")
                                .padding(.init(top: 10, leading: 22, bottom: 10, trailing: 16))
                        }

                        Rectangle()
                            .fill(MyColor.getColor(68, 82, 87))
                            .frame(width: 1.3, height: 23 + additionalHeight)

                        ZStack(alignment: .leading) {
                            if text.isEmpty {
                                Text("type_message".localized())
                                    .foregroundColor(ColorList.white_30.color)
                                    .font(MyFont.getFont(.NORMAL, 18))
                                    .padding(.init(top: 0, leading: 13, bottom: 0, trailing: 5))
                            }

                            Editor()
                                .frame(height: 40 + additionalHeight)
                                .padding(.init(top: 9, leading: 8, bottom: 8, trailing: 3))
                        }
                        Button(action: {
                            if !text.isEmpty && !translateProcess && !sendTextProcess {
                                withAnimation {
                                    translateProcess.toggle()
                                    translateAction(text)
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
                            if !text.isEmpty && !sendTextProcess && !translateProcess {
                                withAnimation {
                                    sendTextProcess.toggle()
                                    sendAction(text)
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
                }.frame(height: 50 + additionalHeight)
                .padding(.init(top: 21, leading: 18, bottom: 30, trailing: 18))
                .frame(width: UIScreen.main.bounds.width, height: 101 + additionalHeight)
            }
            .frame(width: UIScreen.main.bounds.width, height: ((editMode || replyMode) ? 151 : 101) + additionalHeight)
    }

    private func calculateSize() {
        let size = self.text.getLinesHeight(viewVidth: UIScreen.main.bounds.width - 189, fontSize: 18)
        
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

    fileprivate func Editor() -> some View {
        if #available(iOS 16.0, *) {
           return TextEditor(text: $text)
                .foregroundColor(ColorList.white.color)
                .autocapitalization(.sentences)
                .scrollContentBackground(.hidden)
                .background(MyColor.getColor(0, 0, 0, 0))
                .font(MyFont.getFont(.BOLD, 18))
                .onChange(of: text) { _ in
                    calculateSize()
                }
        } else {
            return TextEditor(text: $text)
                .foregroundColor(ColorList.white.color)
                .autocapitalization(.sentences)
                .background(MyColor.getColor(0, 0, 0, 0))
                .font(MyFont.getFont(.BOLD, 18))
                .onChange(of: text) { _ in
                    calculateSize()
                }
        }
    }
}
