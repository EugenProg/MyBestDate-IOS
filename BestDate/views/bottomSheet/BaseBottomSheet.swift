//
//  BaseBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 11.06.2022.
//

import SwiftUI

struct BaseBottomSheet: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = BaseButtonSheetMediator.shared
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    @State var offset: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                Rectangle()
                    .fill(store.state.activeBottomSheet.style.backColor)
                    .cornerRadius(radius: 33, corners: [.topLeft, .topRight])
                    .frame(height: 33)
                    .offset(x: 0, y: offset)
                    Group {
                        switch store.state.activeBottomSheet {
                        case .GENDER: GenderBottomSheet { dismiss() }
                        case .PHOTO_SETTINGS: PhotoSettingsBottomSheet { dismiss() }
                        case .NOT_CORRECT_PHOTO: NotCorrectPhotoBottomSheet { dismiss() }
                        case .QUESTIONNAIRE_SINGLE_SELECT: QuestionnaireSingleSelectBottomSheet { dismiss() }
                        case .QUESTIONNAIRE_SEEK_BAR: QuestionnaireSeekBarBottomSheet { dismiss() }
                        case .QUESTIONNAIRE_SEARCH: QuestionnaireSearchBotomSheet { dismiss() }
                        case .QUESTIONNAIRE_MULTY_SELECT: QuestionnaireMultySelectBottomSheet { dismiss() }
                        case .MAIN_LOCATION: MainLocationBottomSheet { dismiss() }
                        case .MAIN_ONLINE: MainOnlineBottomSheet { dismiss() }
                        case .CHAT_ACTIONS: ChatActionsBottomSheet { dismiss() }
                        }
                    }.frame(width: width, height: store.state.activeBottomSheet.heightMode.height)
                    .padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight + 16, trailing: 0))
                    .background(store.state.activeBottomSheet.style.backColor)
                    .offset(x: 0, y: offset)
            }.onTapGesture {  }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            changeAction(value: value)
                        }
                        .onEnded { value in
                            endAction(value: value)
                        }
                )
        }.frame(width: width, height: height)
            .background(ColorList.white_5.color)
            .onTapGesture {
                closeAction()
                dismiss()
            }
            .onAppear { withAnimation { offset = 0 } }
    }
    
    private func changeAction(value: DragGesture.Value) {
        let result = value.translation.height
        
        if (result > 0) {
            offset = value.translation.height
        }
    }
    
    private func endAction(value: DragGesture.Value) {
        let result = value.translation.height
        
        if result > (store.state.activeBottomSheet.heightMode.height ?? 400) / 2 {
            closeAction()
            dismiss()
        } else {
            withAnimation { offset = 0 }
        }
    }
    
    private func dismiss() {
        withAnimation {
            offset = store.state.activeBottomSheet.heightMode.height ?? height
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            store.dispatch(action: .hideBottomSheet)
        })
    }

    private func closeAction() {
        if mediator.closeAction != nil {
            withAnimation {
                mediator.closeAction!(store.state.activeBottomSheet)
            }
        }
    }
}

enum BottomSheetHeight: String {
    case LOW
    case MIDDLE
    case HEIGHT
    case FULL
    case AUTO
    
    var height: CGFloat? {
        let screenHeight = UIScreen.main.bounds.height
        
        switch self {
        case .LOW: return screenHeight / 4
        case .MIDDLE: return screenHeight / 2
        case .HEIGHT: return (screenHeight / 4) * 3
        case .FULL: return screenHeight
        case .AUTO: return nil
        }
    }
}
