//
//  BunningModalView.swift
//  BestDate
//
//  Created by Евгений on 26.02.2023.
//

import SwiftUI

struct BunningModalView: View {

    var background: LinearGradient
    var headerImage: String
    var title: String
    var description: String
    var color: Color

    var closeAction: () -> Void
    var activateAction: () -> Void

    @State var visible = false
    @State var showAnimation = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(MyColor.getColor(255, 255, 255, 0.1))
                        .background(background)
                        .cornerRadius(18)
                        .frame(width: UIScreen.main.bounds.width - 36, height: 549)

                    Image("bg_bunning_decor")

                    VStack(spacing: 0) {
                        HStack {
                            Spacer()

                            DialogCloseButton {
                                closeAction()
                            }
                        }.padding(.init(top: 36, leading: 85, bottom: 0, trailing: 28))

                        DialogBunningHeader(imageName: headerImage)

                        DialogBunningText(title: title, description: description, color: color)

                        Spacer()

                        DialogActivateButton(color: color) {
                            activateAction()
                        }
                    }.frame(width: UIScreen.main.bounds.width - 36)
                }
                .frame(width: UIScreen.main.bounds.width - 36, height: 549)
                .offset(y: visible ? 50 : (UIScreen.main.bounds.height - 549) / 2 + 549)
                .onTapGesture { }
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100)
        }
        .onAppear {
            withAnimation { visible = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation { showAnimation = true }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
                withAnimation { showAnimation = false }
            }
        }
    }
}

struct DialogCloseButton: View {

    var clickAction: (() -> Void)? = nil

    var body: some View {
        Button(action: {
            withAnimation {
                if clickAction != nil {
                    clickAction!()
                }
            }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(ColorList.white_5.color)

                Image("ic_close_white")
                    .resizable()
                    .frame(width: 16, height: 16)
            }.frame(width: 48, height: 46)
        }
    }
}

struct DialogBunningHeader: View {
    var imageName: String

    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(MyColor.getColor(186, 0, 255, 0.12))
                    .background(MyColor.getColor(63, 77, 85))
                    .cornerRadius(16)

                Image("ic_star")
            }.frame(width: 68, height: 68)
                .padding(.init(top: 5.5, leading: 14, bottom: 0, trailing: 14))

            Image(imageName)
                .padding(.init(top: 0, leading: 71, bottom: 53, trailing: 0))
        }
        .padding(.top, 33)
    }
}

struct DialogBunningText: View {
    var title: String
    var description: String
    var color: Color

    var body: some View {
        VStack {
            VStack(alignment: .trailing) {
                Text("activate_".localized())
                    .foregroundColor(ColorList.white.color)
                    .font(MyFont.getFont(.BOLD, 32)) +
                Text("Pro")
                    .foregroundColor(color)
                    .font(MyFont.getFont(.BOLD, 32))

                Text(title.localized().uppercased())
                    .foregroundColor(color)
                    .font(MyFont.getFont(.NORMAL, 14))
            }

            Text(description.localized())
                .foregroundColor(ColorList.white.color)
                .font(MyFont.getFont(.NORMAL, 16))
                .padding(.top, 88)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 17)
    }
}

struct DialogActivateButton: View {

    var color: Color
    var clickAction: (() -> Void)? = nil

    var body: some View {
        Button(action: {
            withAnimation {
                if clickAction != nil {
                    clickAction!()
                }
            }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 23)
                    .fill(color)

                Text("choose_the_plan".localized())
                    .foregroundColor(MyColor.getColor(51, 51, 51))
                    .font(MyFont.getFont(.BOLD, 18))
            }.frame(width: 248, height: 46)
        }
        .padding(.bottom, 46)
    }
}
