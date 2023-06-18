//
//  PushScreen.swift
//  BestDate
//
//  Created by Евгений on 01.09.2022.
//

import SwiftUI

struct PushScreen: View {
    @EnvironmentObject var store: Store
    @State var visible: Bool = false
    @State var offsetReaderActive: Bool = false

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 0) {
                    ZStack {
                        PositionIndicators(type: .moving)
                            .frame(height: 0)
                        Group {
                            switch store.state.activePush {
                            case .like: LikePushView() { dismiss() }
                            case .match: MatchPushView() { dismiss() }
                            case .invitation: InvitationPushView() { dismiss() }
                            case .invitation_answer: InvitationPushView() { dismiss() }
                            case .moderation_success: ModerationSuccessPushView() { dismiss() }
                            case .moderation_failure: ModerationFailurePushView() { dismiss() }
                            default: DefaultPushView() { dismiss() }
                            }
                        }
                    }.offset(y: visible ? 0 : -200)
                        .padding(.init(top: 32, leading: 18, bottom: 0, trailing: 18))
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100)
            }
            .background(PositionIndicators(type: .moving))
            .onPreferenceChange(PositionPreferenceKey.self) { values in
                DispatchQueue.main.async {
                    if (values.last?.y ?? 100) < 90 && offsetReaderActive {
                        dismiss()
                    }
                }
            }
            .onAppear {
                withAnimation { visible = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    offsetReaderActive = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    dismiss()
                }
            }
        }
    }

    private func dismiss() {
        withAnimation { visible = false }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation { store.state.showPushNotification = false }
        }
    }
}

