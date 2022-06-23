//
//  ProfilePhotoScreen.swift
//  BestDate
//
//  Created by Евгений on 14.06.2022.
//

import SwiftUI

struct ProfilePhotoScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var registrationHolder = RegistrationDataHolder.shared
    @ObservedObject var ediorHolder = PhotoEditorDataHolder.shared
    
    @State var process: Bool = false
    @State var isShowingPhotoLibrary = false
    
    var body: some View {
        VStack {
            ZStack {
                if registrationHolder.imageList.count > 0 {
                    BluredImageHeaderView(image: $registrationHolder.imageList.last ?? $registrationHolder.imageList[0])
                }
                
                VStack {
                    ZStack {
                        Circle()
                            .stroke(ColorList.main.color, lineWidth: 3)
                            .background(ColorList.main.color)
                            .cornerRadius(55)
                            .shadow(color: MyColor.getColor(17, 24, 28, 0.6), radius: 16, y: 3)
                            .frame(width: 110, height: 110)
                        if registrationHolder.imageList.count == 0 {
                            Image("ic_user_cirlce_add")
                        } else {
                            Image(uiImage: registrationHolder.imageList.last ?? registrationHolder.imageList[0])
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .frame(width: 104, height: 104, alignment: .center)
                        }
                    }.padding(.init(top: 150, leading: 32, bottom: 32, trailing: 32))
                    
                    Spacer()
                }.zIndex(15)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    HStack {
                        BackButton(style: registrationHolder.imageList.count > 0 ? .white : .black)
                        
                        Spacer()

                        if registrationHolder.imageList.count > 0 {
                            TextButton(text: "next", textColor: ColorList.white.color) {
                                store.dispatch(action: .navigate(screen: .QUESTIONNAIRE))
                            }
                        }
                    }.padding(.init(top: 32, leading: 32, bottom: 15, trailing: 32))
                    
                    
                    Title(textColor: registrationHolder.imageList.count > 0 ? ColorList.white.color : ColorList.main.color, text: "set_a_profile_photo")
                    
                    ZStack {
                        Rectangle()
                            .fill(Color(ColorList.main.uiColor))
                            .cornerRadius(radius: 33, corners: [.topLeft, .topRight])
                        VStack(spacing: 2) {
                            Text(registrationHolder.name)
                                .foregroundColor(ColorList.white.color)
                                .font(MyFont.getFont(.BOLD, 26))
                            
                            Text(registrationHolder.birthDate.toString())
                                .foregroundColor(ColorList.white_80.color)
                                .font(MyFont.getFont(.BOLD, 16))
                            
                            Text(registrationHolder.gender)
                                .foregroundColor(ColorList.white_60.color)
                                .font(MyFont.getFont(.BOLD, 16))
                                .padding(.init(top: 16, leading: 0, bottom: 0, trailing: 0))
                            
                            Text(registrationHolder.email)
                                .foregroundColor(ColorList.white_90.color)
                                .font(MyFont.getFont(.BOLD, 20))
                                .padding(.init(top: 16, leading: 0, bottom: 0, trailing: 0))
                            
                            HorisontalPhotoListView(imagesList: $registrationHolder.imageList) { image in
                                ediorHolder.croppedPhoto = image
                                store.dispatch(action: .showBottomSheet(view: .PHOTO_SETTINGS))
                            }
                            
                            Spacer()
                            
                            Text("you_can_upload_up_to_9_photos_to_your_profile")
                                .foregroundColor(ColorList.white_60.color)
                                .font(MyFont.getFont(.NORMAL, 18))
                                .multilineTextAlignment(.center)
                                .lineSpacing(8)
                            
                            Spacer()
                            
                            StandardButton(style: .white, title: "upload_a_photo", loadingProcess: $process) {
                                if registrationHolder.imageList.count < 9 {
                                    isShowingPhotoLibrary.toggle()
                                } else {
                                    store.dispatch(action: .show(message: NSLocalizedString("you_can_upload_only_9_photo", comment: "Only 9")))
                                }
                            }.padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight + 32, trailing: 0))
                            
                        }.padding(.init(top: 70, leading: 0, bottom: 0, trailing: 0))
                    }.frame(width: UIScreen.main.bounds.width)
                        .padding(.init(top: 45, leading: 0, bottom: 0, trailing: 0))
                }
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .topLeading)
            .background(ColorList.white.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.white.color, style: .darkContent))
            }
            .sheet(isPresented: $isShowingPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    ediorHolder.selectedPhoto = image
                    store.dispatch(action: .navigate(screen: .PHOTO_EDITING))
                }
            }
    }
}

struct ProfilePhotoScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoScreen()
    }
}
