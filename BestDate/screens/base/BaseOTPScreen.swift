//
//  BaseOTPScreen.swift
//  BestDate
//
//  Created by Евгений on 12.06.2022.
//

import SwiftUI

struct BaseOTPScreen: View {
    @EnvironmentObject var store: Store

    var title: String
    var description: String
    var email: String
    @State var code: String = ""
    @State var codeInputError: Bool = false
    
    var confirmAction: (String) -> Void
    var resendAction: (() -> Void)? = nil
    
    @Binding var process: Bool
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    BackButton(style: .black)
                        .padding(.init(top: 32, leading: 32, bottom: 15, trailing: 0))
                    
                    Title(textColor: ColorList.main.color, text: title)
                    
                    HeaderText(textColor: ColorList.main_70.color, text: description)
                    
                    Text(email)
                        .foregroundColor(ColorList.main_90.color)
                        .font(MyFont.getFont(.BOLD, 20))
                        .padding(.init(top: 10, leading: 32, bottom: 10, trailing: 32))
                    
                    ZStack {
                        Rectangle()
                            .fill(Color(ColorList.main.uiColor))
                            .cornerRadius(radius: 33, corners: [.topLeft, .topRight])
                        VStack(spacing: 0) {
                            StandardInputView(hint: "enter_the_confirmation_code", imageName: nil, inputText: $code, errorState: $codeInputError, inputType: .numberPad) { text in
                                inputAction(text: text)
                            }
                            
                            StandardButton(style: .white, title: "next", loadingProcess: $process) {
                                validate()
                            }.padding(.init(top: 16, leading: 0, bottom: 25, trailing: 0))
                            
                            Spacer()
                            VStack(spacing: 14) {
                                Text("i_didn_t_get_the_code_send_it_again")
                                    .foregroundColor(ColorList.white_60.color)
                                    .font(MyFont.getFont(.NORMAL, 16))
                                Text("_60_second")
                                    .foregroundColor(ColorList.white.color)
                                    .font(MyFont.getFont(.BOLD, 16))
                                    .padding(.init(top: 0, leading: 32, bottom: store.state.statusBarHeight + 32, trailing: 32))
                            }.onTapGesture {
                                if resendAction != nil { resendAction!() }
                            }
                            
                        }.padding(.init(top: 25, leading: 0, bottom: 0, trailing: 0))
                    }.frame(width: UIScreen.main.bounds.width)
                }
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .topLeading)
            .background(ColorList.white.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.white.color, style: .darkContent))
            }
    }
    
    private func validate() {
        if code.count < 6 { codeInputError = true }
        else { confirmAction(code) }
    }
    
    private func inputAction(text: String) {
        if text.count == 6 { confirmAction(code) }
    }
}
