//
//  SwichSelectorView.swift
//  BestDate
//
//  Created by Евгений on 15.06.2022.
//

import SwiftUI

struct SwichSelectorView: View {
    @Binding var isActive: Bool?
    var hint: String
    var text: String
    var showInfoImage: Bool = true
    
    var clickInfoAction: () -> Void
    var checkAction: (Bool) -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .stroke(isActive == true ? ColorList.light_blue.color : MyColor.getColor(231, 238, 242, 0.12), lineWidth: 2)
                .background(ColorList.main.color)
                .cornerRadius(24)
            
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(hint.localized())
                        .foregroundColor(ColorList.white_60.color)
                        .font(MyFont.getFont(.NORMAL, 12))
                    Text(text.localized())
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.NORMAL, 18))
                }
                
                Spacer()
                
                if showInfoImage {
                    Image("ic_info")
                        .onTapGesture {
                            withAnimation { clickInfoAction() }
                        }
                }
                
                SwitchButtonView(isActive: $isActive) { checked in
                    checkAction(checked)
                    isActive = checked
                }
                
            }.padding(.init(top: 0, leading: 24, bottom: 0, trailing: 8))
            
        }.frame(height: 76)
            .padding(.init(top: 5, leading: 18, bottom: 5, trailing: 18))
    }
}
