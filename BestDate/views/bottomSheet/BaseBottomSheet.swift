//
//  BaseBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 11.06.2022.
//

import SwiftUI

struct BaseBottomSheet: View {
    @EnvironmentObject var store: Store
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
                        case .GENDER: GenderBottomSheet { dissmiss() }
                        case .PHOTO_SETTINGS: PhotoSettingsBottomSheet { dissmiss() }
                        case .NOT_CORRECT_PHOTO: NotCorrectPhotoBottomSheet { dissmiss() }
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
                dissmiss()
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
            dissmiss()
        } else {
            withAnimation { offset = 0 }
        }
    }
    
    private func dissmiss() {
        withAnimation {
            offset = store.state.activeBottomSheet.heightMode.height ?? height
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            store.dispatch(action: .hideBottomSheet)
        })
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
