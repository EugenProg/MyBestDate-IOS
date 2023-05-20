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
    @ObservedObject var mainMediator = MainMediator.shared
    @ObservedObject var editorMediator = PhotoEditorMediator.shared
    @ObservedObject var photoMediator = PhotoSettingsSheetMediator.shared
    @ObservedObject var pickerMediator = ImagePickerMediator.shared
    @ObservedObject var networkManager = NetworkManager.shared
    @State var showHeader = false
    @State var logoutProccess: Bool = false

    var body: some View {
        ZStack {
            if showHeader {
                BluredImageHeaderView(image: $mediator.mainPhoto, enableBlur: false)
            }

            RefreshScrollView(onRefresh: { done in
                mediator.updateUserData { done() }
            } ) {
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
                                .onTapGesture {
                                    if mediator.user.photos?.isEmpty == true {
                                        pickerMediator.isShowingPhotoLibrary.toggle()
                                    } else {
                                        goToImageViewer(index: mediator.getMainPhotoIndex())
                                    }
                                }

                        }.padding(.init(top: 84, leading: 32, bottom: 32, trailing: 32))

                        Spacer()
                    }.zIndex(15)

                    VStack(alignment: .leading, spacing: 0) {
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

                                Text(mediator.user.getBirthday())
                                    .foregroundColor(ColorList.white_80.color)
                                    .font(MyFont.getFont(.BOLD, 16))

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .top, spacing: 15) {
                                        CoinsBoxView(coinsCount: $mainMediator.coinsCount) {

                                        }

                                        ProfileButtonView(name: "matches_list", image: "ic_matches", isActive: mediator.hasNewMatches) {
                                            store.dispatch(action: .navigate(screen: .MATCHES_LIST))
                                        }

                                        ProfileButtonView(name: "cards", image: "ic_add", isActive: mediator.hasNewInvitations) {
                                            store.dispatch(action: .navigate(screen: .INVITATION))
                                        }

                                        ProfileButtonView(name: "likes", image: "ic_is_liked", isActive: mediator.hasNewLikes) {
                                            store.dispatch(action: .navigate(screen: .LIKES_LIST))
                                        }

                                        ProfileButtonView(name: "my_duels", image: "ic_my_duels", isActive: mediator.hasNewDuels) {
                                            store.dispatch(action: .navigate(screen: .MY_DUELS))
                                        }
                                    }.padding(.init(top: 28, leading: 18, bottom: 3, trailing: 18))
                                }
                            }.padding(.init(top: 75, leading: 0, bottom: 0, trailing: 0))
                        }.frame(height: 231, alignment: .top)
                            .padding(.init(top: 139, leading: 0, bottom: 0, trailing: 0))

                        ZStack {
                            Rectangle()
                                .fill(ColorList.main.color)

                            VStack(spacing: 0) {
                                ProfilePhotoLineView(imagesList: $mediator.profileImages, addAction: addImage()) { selectedImage in
                                    photoMediator.setImage(image: selectedImage)
                                    photoMediator.callPage = .PROFILE
                                    store.dispatch(action: .showBottomSheet(view: .PHOTO_SETTINGS))
                                }.padding(.init(top: 10, leading: 0, bottom: 0, trailing: 0))

                                DirrectionLineButtonView(name: "questionnaire", icon: "ic_document", buttonColor: ColorList.pink_5.color) {
                                    QuestionnaireMediator.shared.setEditInfo(user: mediator.user, editMode: true)
                                    store.dispatch(action: .navigate(screen: .QUESTIONNAIRE))
                                }.padding(.init(top: 40, leading: 0, bottom: 0, trailing: 0))

                                DirrectionLineButtonView(name: "personal_data", icon: "ic_profile", buttonColor: ColorList.white_5.color) {
                                    PersonalDataMediator.shared.setUserData()
                                    store.dispatch(action: .navigate(screen: .PERSONAL_DATA))
                                }

                                DirrectionLineButtonView(name: "settings", icon: "ic_setting", buttonColor: ColorList.light_blue_5.color) {
                                    SettingsMediator.shared.getUserSettings()
                                    store.dispatch(action: .navigate(screen: .SETTINGS))
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

            VStack {
                HStack {
                    BackButton(style: .white)

                    Spacer()

                    Button(action: {
                        store.dispatch(action: .showBottomSheet(view: .PROFILE_ADDITIONALLY))
                    }) {
                        Image("ic_menu_dots")
                            .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 0))
                    }
                }.padding(.init(top: 32, leading: 32, bottom: 15, trailing: 32))
                Spacer()
            }

        }.frame(width: UIScreen.main.bounds.width)
            .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
            .sheet(isPresented: $mediator.showShareSheet) {
                ActivityViewController(activityItems:
                                        [DeeplinkCreator().get(userId: mediator.user.id, userName: mediator.user.name ?? "")]
                )
            }
            .onChange(of: networkManager.isConnected, perform: { newValue in
                if newValue {
                    mediator.updateUserData { }
                }
            })
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.main.color, style: .lightContent))

                mediator.setUser(user: UserDataHolder.shared.getUser())
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: { withAnimation { showHeader = true } })
            }
            .sheet(isPresented: $pickerMediator.isShowingPhotoLibrary) {
                ImagePicker { image in
                    editorMediator.newPhoto = image
                    photoMediator.callPage = .PROFILE
                    store.dispatch(action: .navigate(screen: .PHOTO_EDITING))
                }
            }
    }

    private func addImage() -> () -> Void {
        {
            pickerMediator.isShowingPhotoLibrary.toggle()
        }
    }

    private func goToImageViewer(index: Int) {
        if mediator.user.photos?.isEmpty != true {
            withAnimation {
                mediator.selectedImage = index
                store.dispatch(action: .navigate(screen: .PROFILE_IMAGES))
            }
        }
    }
}
