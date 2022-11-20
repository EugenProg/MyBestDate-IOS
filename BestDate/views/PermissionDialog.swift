//
//  PermissionDialog.swift
//  BestDate
//
//  Created by Евгений on 17.11.2022.
//

import SwiftUI

struct PermissionDialog: View {
    @EnvironmentObject var store: Store
    @State var visible = false

    fileprivate func actionButton(name: String, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(ColorList.white.color)
                    .frame(height: 25)

                Text(name.localized())
                    .foregroundColor(ColorList.main.color)
                    .font(MyFont.getFont(.BOLD, 14))
                    .padding(.init(top: 6, leading: 14, bottom: 6, trailing: 14))
            }
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(MyColor.getColor(190, 239, 255, 0.15), lineWidth: 2)
                        .background(ColorList.main.color)
                        .cornerRadius(16)

                    VStack(spacing: 16) {
                        Text("attention".localized())
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.BOLD, 22))

                        Text("you_have_not_given_permission_to_access_images".localized())
                            .foregroundColor(ColorList.white_80.color)
                            .multilineTextAlignment(.center)
                            .font(MyFont.getFont(.BOLD, 16))
                            .padding(.init(top: 0, leading: 16, bottom: 3, trailing: 16))

                        HStack(spacing: 16) {
                            actionButton(name: "cancel") {
                                closeDialog()
                            }

                            actionButton(name: "settings") {
                                let settingsURL = URL(string: UIApplication.openSettingsURLString)!
                                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                                closeDialog()
                            }
                        }.padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                }.frame(minWidth: 246, maxWidth: 256, minHeight: 185, maxHeight: 195)
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100)
                .opacity(visible ? 1 : 0)
        }.onTapGesture { }
            .onAppear {
                withAnimation { visible = true }
            }
    }

    func closeDialog() {
        withAnimation { visible = false }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            store.state.showSetPermissionDialog = false
        }
    }
}
