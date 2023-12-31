//
//  LogoutButtonView.swift
//  BestDate
//
//  Created by Евгений on 17.07.2022.
//

import SwiftUI

struct LogoutButtonView: View {
    @Binding var loadingProcess: Bool

    var clickAction: () -> Void
    
    var body: some View {
        Button(action: {
            if !loadingProcess { withAnimation { clickAction() } } 
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(MyColor.getColor(231, 238, 242, 0.12), lineWidth: 1)
                    .background(ColorList.white_5.color)
                    .cornerRadius(16)

                if loadingProcess {
                    LoadingDotsView()
                } else {
                    HStack(spacing: 15) {
                        Image("ic_sign_out")
                        
                        Text("sign_out".localized())
                            .foregroundColor(ColorList.white_70.color)
                            .font(MyFont.getFont(.BOLD, 14))
                    }.padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
                }

            }.frame(width: 136, height: 58)
        }
    }
}
