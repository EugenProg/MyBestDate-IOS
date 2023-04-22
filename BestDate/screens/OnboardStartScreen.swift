//
//  OnboardStartScreen.swift
//  BestDate
//
//  Created by Евгений on 05.06.2022.
//

import SwiftUI

struct OnboardStartScreen: View {
    @EnvironmentObject var store: Store
    let height = UIScreen.main.bounds.height
    @State var process: Bool = false
    
    var body: some View {
        ZStack {
            Image("ic_decor_pink")
                .resizable()
            VStack(spacing: 0) {
                HStack {
                    Image("ic_logoName")
                    Spacer()
                    TextButton(text: "skip", textColor: ColorList.white.color) {
                        store.dispatch(action: .navigate(screen: .AUTH))
                    }
                }.padding(.init(top: 32, leading: 32, bottom: 0, trailing: 32))
            }.frame(height: height, alignment: .top)
            
            let halfHeight = height / 2
            let offsetHeight = (halfHeight - 250) / 2
            
            VStack(spacing: 0) {
                Image("ic_couple_first")
                    .resizable()
                    .frame(width: 250, height: 250)
            }.padding(.init(top: offsetHeight, leading: 0, bottom: halfHeight + offsetHeight, trailing: 0))
            
            VStack(spacing: 0) {
                Text("dating_without_restrictions")
                    .foregroundColor(ColorList.main.color)
                    .font(MyFont.getFont(.BOLD, 38))
                    .multilineTextAlignment(.center)
                    .padding(.init(top: 20, leading: 0, bottom: 20, trailing: 0))
                Text("communicate_and_get_to_know_people_from_all_over_the_world")
                    .foregroundColor(ColorList.main_70.color)
                    .font(MyFont.getFont(.NORMAL, 18))
                    .lineSpacing(7.2)
                    .multilineTextAlignment(.center)
            }.frame(height: halfHeight - 64, alignment: .top)
            .padding(.init(top: halfHeight, leading: 32, bottom: 0, trailing: 32))
            
            VStack(spacing: 0) {
                HStack(spacing: 10) {
                    CirclePointButton(withOpacityRing: true){ }
                    CirclePointButton(withOpacityRing: false) { store.dispatch(action: .navigate(screen: .ONBOARD_SECOND)) }
                    CirclePointButton(withOpacityRing: false) {
                        store.dispatch(action: .navigate(screen: .AUTH))
                    }
                    Spacer()
                    CircleImageButton(imageName: "ic_arrow_right_pink", strokeColor: MyColor.getColor(242, 138, 229, 0.18), shadowColor: MyColor.getColor(137, 117, 135, 0.63), loadingProcess: $process) { store.dispatch(action: .navigate(screen: .ONBOARD_SECOND)) }
                }.padding(.init(top: 0, leading: 32, bottom: store.state.statusBarHeight + 32, trailing: 32))
            }.frame(height: height, alignment: .bottom)
            
        }.background(ColorList.pink.color.edgesIgnoringSafeArea(.bottom))
        .onAppear {
            store.dispatch(action:
                    .setScreenColors(status: ColorList.main.color, style: .lightContent))
        }
    }
}

struct OnboardStartScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardStartScreen()
    }
}
