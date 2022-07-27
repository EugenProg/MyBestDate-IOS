//
//  ProfileScreen.swift
//  BestDate
//
//  Created by Евгений on 16.07.2022.
//

import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = ProfileMediator.shared
    @ObservedObject var editorMediator = PhotoEditorMediator.shared
    @ObservedObject var photoMediator = PhotoSettingsSheetMediator.shared
    @State var showHeader = false
    @State var logoutProccess: Bool = false

    @State var isShowingPhotoLibrary = false

    var body: some View {
        ZStack {
            if showHeader {
                BluredImageHeaderView(image: $mediator.mainPhoto, enableBlur: false)
            }

            ScrollView(.vertical, showsIndicators: false) {
                ZStack {
                    VStack {
                        ZStack {
                            Circle()
                                .stroke(ColorList.main.color, lineWidth: 3)
                                .background(ColorList.main.color)
                                .cornerRadius(55)
                                .shadow(color: MyColor.getColor(17, 24, 28, 0.6), radius: 16, y: 3)
                                .frame(width: 110, height: 110)

                            UpdateImageView(image: $mediator.mainPhoto)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .frame(width: 104, height: 104, alignment: .center)

                        }.padding(.init(top: 84, leading: 32, bottom: 32, trailing: 32))

                        Spacer()
                    }.zIndex(15)

                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            BackButton(style: .white)

                            Spacer()

                            Button(action: {

                            }) {
                                Image("ic_menu_dots")
                                    .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 0))
                            }
                        }.padding(.init(top: 32, leading: 32, bottom: 15, trailing: 32))


                        ZStack {
                            Rectangle()
                                .fill(MyColor.getColor(36, 43, 47))
                                .cornerRadius(radius: 33, corners: [.topLeft, .topRight])

                            VStack(spacing: 0) {
                                HStack(spacing: 12) {
                                    Text(mediator.user.name ?? "")
                                        .foregroundColor(ColorList.white.color)
                                        .font(MyFont.getFont(.BOLD, 26))

                                    Image((mediator.user.questionnaire?.isFull() ?? false) ? "ic_verify_active" : "ic_verify_gray")
                                        .resizable()
                                        .frame(width: 20, height: 20)

                                }.padding(.init(top: 0, leading: 32, bottom: 0, trailing: 0))

                                Text(mediator.user.birthday?.toDate().toString() ?? "")
                                    .foregroundColor(ColorList.white_80.color)
                                    .font(MyFont.getFont(.BOLD, 16))

                                HStack(alignment: .top) {
                                    CoinsBoxView(coinsCount: 10) {

                                    }

                                    Spacer()

                                    ProfileButtonView(name: "like", image: "ic_menu_match_active", isActive: true) {
                                    }

                                    ProfileButtonView(name: "my_duels", image: "ic_my_duels", isActive: true) {
                                        store.dispatch(action: .navigate(screen: .MY_DUELS))
                                    }
                                }.padding(.init(top: 28, leading: 18, bottom: 0, trailing: 18))
                            }.padding(.init(top: 75, leading: 0, bottom: 0, trailing: 0))
                        }.frame(height: 231, alignment: .top)
                            .padding(.init(top: 65, leading: 0, bottom: 0, trailing: 0))

                        ZStack {
                            Rectangle()
                                .fill(ColorList.main.color)

                            VStack(spacing: 0) {
                                HStack {
                                    Spacer()
                                    HStack(spacing: 9) {
                                        Text("See All")
                                            .foregroundColor(ColorList.white_60.color)
                                            .font(MyFont.getFont(.NORMAL, 12))

                                        Image("ic_arrow_right_white")
                                            .resizable()
                                            .frame(width: 5, height: 10)
                                            .opacity(0.6)
                                    }.padding(.init(top: 10, leading: 16, bottom: 13, trailing: 18))
                                        .onTapGesture {

                                    }
                                }

                                ProfilePhotoLineView(imagesList: $mediator.profileImages, addAction: addImage()) { selectedImage in
                                    photoMediator.selectedPhoto = selectedImage
                                    photoMediator.callPage = .PROFILE
                                    store.dispatch(action: .showBottomSheet(view: .PHOTO_SETTINGS))
                                }

                                DirrectionLineButtonView(name: "questionnaire", icon: "ic_document", buttonColor: ColorList.pink_5.color) {
                                    QuestionnaireMediator.shared.setEditInfo(user: mediator.user, editMode: true)
                                    store.dispatch(action: .navigate(screen: .QUESTIONNAIRE))
                                }.padding(.init(top: 40, leading: 0, bottom: 0, trailing: 0))

                                DirrectionLineButtonView(name: "personal_data", icon: "ic_profile", buttonColor: ColorList.white_5.color) {

                                }

                                DirrectionLineButtonView(name: "settings", icon: "ic_setting", buttonColor: ColorList.light_blue_5.color) {

                                }

                                HStack {
                                    LogoutButtonView(loadingProcess: $logoutProccess) {
                                        logoutProccess.toggle()
                                        mediator.logout {
                                            DispatchQueue.main.async {
                                                logoutProccess.toggle()
                                                store.dispatch(action: .navigate(screen: .AUTH, clearBackStack: true))
                                            }

                                        }
                                    }
                                    Spacer()
                                }.padding(.init(top: 40, leading: 18, bottom: store.state.statusBarHeight + 32, trailing: 18))
                            }
                        }
                    }
                }
            }

        }.frame(width: UIScreen.main.bounds.width)
            .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.main.color, style: .lightContent))

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: { withAnimation { showHeader = true } })
            }
            .sheet(isPresented: $isShowingPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    editorMediator.newPhoto = image
                    photoMediator.callPage = .PROFILE
                    store.dispatch(action: .navigate(screen: .PHOTO_EDITING))
                }
            }
    }

    private func addImage() -> () -> Void {
        {
            isShowingPhotoLibrary.toggle()
        }
    }
}
