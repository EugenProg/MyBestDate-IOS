//
//  GeolocationScreen.swift
//  BestDate
//
//  Created by Евгений on 13.06.2022.
//

import SwiftUI

struct GeolocationScreen: View {
    @EnvironmentObject var store: Store
    @State var process: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    let size = UIScreen.main.bounds.height / 2
                    Image("ic_geolocation")
                        .resizable()
                        .frame(width: size / 1.29, height: size, alignment: .center)
                    VStack {
                        Text("geolocation_must_be_enabled")
                            .foregroundColor(ColorList.main.color)
                            .font(MyFont.getFont(.BOLD, 38))
                            .multilineTextAlignment(.center)
                            .padding(.init(top: 0, leading: 32, bottom: 0, trailing: 32))
                        
                        Spacer()
                        
                        Text("this_is_necessary_so_that_we_can_make_a_more_suitable_selection")
                            .foregroundColor(ColorList.main_70.color)
                            .font(MyFont.getFont(.NORMAL, 18))
                            .lineSpacing(10)
                            .multilineTextAlignment(.center)
                            .padding(.init(top: 0, leading: 32, bottom: 0, trailing: 32))
                        
                        Spacer()
                        
                        StandardButton(style: .black, title: "enable_geolocation", loadingProcess: $process) {
                            UserDataHolder.setStartScreen(screen: .PROFILE_PHOTO)
                            store.dispatch(action: .navigate(screen: .PROFILE_PHOTO))
                        }
                        
                        SecondStylesTextButton(firstText: "do_it_later", secondText: "skip", firstTextColor: ColorList.main_60.color, secondTextColor: ColorList.main.color) {
                            UserDataHolder.setStartScreen(screen: .PROFILE_PHOTO)
                            store.dispatch(action: .navigate(screen: .PROFILE_PHOTO))
                        }.padding(.init(top: 20, leading: 32, bottom: store.state.statusBarHeight + 32, trailing: 32))
                    }.frame(maxHeight: UIScreen.main.bounds.height / 2, alignment: .bottom)
                }
            }
            
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .topLeading)
            .background(ColorList.white.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.white.color, style: .darkContent))
            }
    }
}

struct GeolocationScreen_Previews: PreviewProvider {
    static var previews: some View {
        GeolocationScreen()
    }
}
