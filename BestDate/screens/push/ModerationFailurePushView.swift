//
//  ModerationFailurePushView.swift
//  BestDate
//
//  Created by Eugen Kopp on 18.06.2023.
//

import SwiftUI

struct ModerationFailurePushView: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = PushMediator.shared

    var closeAction: () -> Void

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(ColorList.pink.color)

                        Image("ic_close_white")
                    }.frame(width: 22, height: 22)

                    Text("sorry".localized())
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 20))

                    Spacer(minLength: 1)
                    
                    ZStack {
                        Text("upload_new_photo".localized())
                            .foregroundColor(ColorList.main.color)
                            .font(MyFont.getFont(.BOLD, 14))
                            .padding(.vertical, 2)
                            .padding(.horizontal, 20)
                    }.background(
                        RoundedRectangle(cornerRadius: 11)
                            .fill(ColorList.light_blue.color)
                    )
                }.padding(.bottom, 16)
                
                Text(mediator.title ?? "Moderation failed")
                    .foregroundColor(ColorList.white.color)
                    .font(MyFont.getFont(.BOLD, 16))
                    .padding(.leading, 4)
                
                Text(mediator.body ?? "Upload another photo")
                    .foregroundColor(ColorList.white_60.color)
                    .font(MyFont.getFont(.BOLD, 14))
                    .padding(.leading, 4)
            }.padding(21)
                .frame(width: UIScreen.main.bounds.width - 36)
        }.background(
            RoundedRectangle(cornerRadius: 32)
                .stroke(MyColor.getColor(255, 255, 255, 0.16), lineWidth: 1)
                .background(ColorList.main.color)
                .cornerRadius(32)
                .shadow(color: MyColor.getColor(17, 24, 28, 0.17), radius: 46, y: 14)
        )
        .onTapGesture {
            closeAction()
            withAnimation {
                ImagePickerMediator.shared.isShowingPhotoLibrary = true
                store.dispatch(action: .navigate(screen: .PROFILE))
            }
        }
    }
}

struct ModerationFailurePushView_Previews: PreviewProvider {
    static var previews: some View {
        ModerationFailurePushView(closeAction: { })
    }
}
