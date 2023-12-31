//
//  ProfilePhotoScreen.swift
//  BestDate
//
//  Created by Евгений on 14.06.2022.
//

import SwiftUI

struct ProfilePhotoScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var photoSettingsMediator = PhotoSettingsSheetMediator.shared
    @ObservedObject var registrationMediator = RegistrationMediator.shared
    @ObservedObject var mediator = PhotoEditorMediator.shared
    @ObservedObject var pickerMediator = ImagePickerMediator.shared
    
    @State var process: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                if mediator.mainPhoto != nil {
                    BluredImageHeaderView(image: $mediator.mainPhoto)
                }
                
                VStack {
                    ZStack {
                        Circle()
                            .stroke(ColorList.main.color, lineWidth: 3)
                            .background(ColorList.main.color)
                            .cornerRadius(55)
                            .shadow(color: MyColor.getColor(17, 24, 28, 0.6), radius: 16, y: 3)
                            .frame(width: 110, height: 110)
                        if mediator.mainPhoto == nil {
                            Image("ic_user_cirlce_add")
                        } else {
                            UpdateImageView(image: $mediator.mainPhoto)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .frame(width: 104, height: 104, alignment: .center)
                        }
                    }.padding(.init(top: 150, leading: 32, bottom: 32, trailing: 32))
                    
                    Spacer()
                }.zIndex(15)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    HStack {
                        BackButton(style: mediator.mainPhoto != nil ? .white : .black)
                        
                        Spacer()

                        if mediator.imageList.count > 0 {
                            TextButton(text: "next", textColor: mediator.mainPhoto != nil ? ColorList.white.color : ColorList.main.color) {
                                UserDataHolder.shared.setStartScreen(screen: .QUESTIONNAIRE)
                                store.dispatch(action: .navigate(screen: .QUESTIONNAIRE))
                            }
                        }
                    }.padding(.init(top: 32, leading: 32, bottom: 0, trailing: 32))
                    
                    
                    Title(textColor: mediator.mainPhoto != nil ? ColorList.white.color : ColorList.main.color, text: "set_a_profile_photo")
                    
                    ZStack {
                        Rectangle()
                            .fill(Color(ColorList.main.uiColor))
                            .cornerRadius(radius: 33, corners: [.topLeft, .topRight])
                        VStack(spacing: 2) {
                            Text(registrationMediator.name)
                                .foregroundColor(ColorList.white.color)
                                .font(MyFont.getFont(.BOLD, 26))
                            
                            Text(registrationMediator.birthDate.toString())
                                .foregroundColor(ColorList.white_80.color)
                                .font(MyFont.getFont(.BOLD, 16))
                            
                            Text(registrationMediator.gender)
                                .foregroundColor(ColorList.white_60.color)
                                .font(MyFont.getFont(.BOLD, 16))
                                .padding(.init(top: 16, leading: 0, bottom: 0, trailing: 0))
                            
                            Text(registrationMediator.email)
                                .foregroundColor(ColorList.white_90.color)
                                .font(MyFont.getFont(.BOLD, 20))
                                .padding(.init(top: 16, leading: 0, bottom: 0, trailing: 0))
                            
                            HorisontalPhotoListView(imagesList: $mediator.imageList) { image in
                                photoSettingsMediator.setImage(image: image)
                                photoSettingsMediator.callPage = .PROFILE_PHOTO
                                store.dispatch(action: .showBottomSheet(view: .PHOTO_SETTINGS))
                            }
                            
                            Spacer()
                            
                            Text("you_can_upload_up_to_9_photos_to_your_profile")
                                .foregroundColor(ColorList.white_60.color)
                                .font(MyFont.getFont(.NORMAL, 18))
                                .multilineTextAlignment(.center)
                                .lineSpacing(8)
                                .padding(.init(top: 0, leading: 18, bottom: 0, trailing: 18))
                            
                            Spacer()
                            
                            StandardButton(style: .white, title: "upload_a_photo", loadingProcess: $process) {
                                if mediator.imageList.count < 9 {
                                    pickerMediator.isShowingPhotoLibrary.toggle()
                                } else {
                                    store.dispatch(action: .show(message: "you_can_upload_only_9_photo".localized()))
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
                        .setScreenColors(status: ColorList.white.color, style: mediator.mainPhoto != nil ? .lightContent : .darkContent))
            }
            .sheet(isPresented: $pickerMediator.isShowingPhotoLibrary) {
                ImagePicker { image in
                    mediator.newPhoto = image
                    photoSettingsMediator.callPage = .PROFILE_PHOTO
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
