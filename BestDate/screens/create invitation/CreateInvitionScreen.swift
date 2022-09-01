//
//  CreateInvitionScreen.swift
//  BestDate
//
//  Created by Евгений on 24.08.2022.
//

import SwiftUI

struct CreateInvitionScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = CreateInvitationMediator.shared

    @State var visible = false
    @State var showFrontSide = true

    @State var loadingProcess: Bool = false

    fileprivate func frontSide() -> some View {
        ZStack {
            Image("bg_invitation_decore")


            Image("ic_invitation_hearts")
                .padding(.init(top: 130, leading: 0, bottom: 0, trailing: 0))

            VStack(spacing: 0) {
                Image("ic_logo_name_pink")
                    .padding(.init(top: 50, leading: 0, bottom: 7, trailing: 0))

                Text(NSLocalizedString("invitation_card", comment: "card").uppercased())
                    .foregroundColor(ColorList.white.color)
                    .font(MyFont.getFont(.BOLD, 19))
                    .padding(.init(top: 7, leading: 0, bottom: 116, trailing: 0))

                StandardButton(style: .white, title: "Open  •  1€", loadingProcess: $loadingProcess) {
                    withAnimation { showFrontSide.toggle() }
                }
                .padding(.init(top: 116, leading: 12, bottom: 23, trailing: 12))
            }.frame(width: 306, height: 454)
        }
        .padding(6)
    }

    fileprivate func backSide() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 3) {
                ForEach(mediator.invitations, id: \.id) { invitation in
                    Button(action: {
//                        mediator.sendInvitation(invitaionId: invitation.id) {
//                            DispatchQueue.main.async {
                                withAnimation {
                                    store.state.showInvitationDialog = false
                                }
//                            }
//                        }
                    }) {
                        invitationItem(invitation: invitation)
                    }
                }
            }
        }.rotation3DEffect(Angle(degrees: -180), axis: (x: 0, y: 1, z: 0))
            .padding(.init(top: 23, leading: 24, bottom: 23, trailing: 24))
    }

    fileprivate func invitationItem(invitation: Invitation) -> some View {
        ZStack {
            Image("bg_create_invitation")

            Text(invitation.name ?? "Sex")
                .foregroundColor(ColorList.white.color)
                .font(MyFont.getFont(.BOLD, 18))
        }.frame(width: 223, height: 44)
        .padding(5)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 32)
                        .fill(MyColor.getColor(244, 248, 250, 0.5))

                    RoundedRectangle(cornerRadius: 28)
                        .fill(ColorList.pink.color)
                        .padding(6)

                    if showFrontSide {
                        frontSide()
                    } else {
                        backSide()
                    }

                }.frame(width: 306, height: 454)
                    .offset(y: visible ? 0 : (UIScreen.main.bounds.height - 454) / 2 + 454)
                    .rotation3DEffect(getRotationAngle(), axis: (x: 0, y: 1, z: 0))
                    .onTapGesture { }
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100)
        }
        .onTapGesture {
            withAnimation {
                //if showFrontSide {
                    store.state.showInvitationDialog = false
              //  }
            }
        }
        .onAppear {
            withAnimation { visible = true }
        }
    }

    private func getRotationAngle() -> Angle {
        if visible && showFrontSide { return Angle(degrees: 0) }
        else if visible && !showFrontSide { return Angle(degrees: -180) }
        else { return Angle(degrees: 180) }
    }
}

