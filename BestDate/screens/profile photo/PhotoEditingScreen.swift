//
//  PhotoEditingScreen.swift
//  BestDate
//
//  Created by Евгений on 14.06.2022.
//

import SwiftUI

struct PhotoEditingScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = PhotoEditorMediator.shared
    
    @State var process: Bool = false
    
    var body: some View {
        VStack {
            ZStack {

                EdiorView(backgroundColor: ColorList.main.color)
                
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        BackButton(style: .white)
                            .padding(.init(top: 32, leading: 32, bottom: 15, trailing: 32))

                        Title(textColor: ColorList.white.color, text: "adding_and_editing_a_photo")
                    }.frame(height: 165)
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 30)
                        .fill(ColorList.transparent.color)
                        .frame(width: UIScreen.main.bounds.width - 14, height: UIScreen.main.bounds.width - 14)
                    
                    Spacer()

                    if UIScreen.main.bounds.height > 800 {

                        Text("you_can_upload_up_to_9_photos_to_your_profile")
                            .foregroundColor(ColorList.white_60.color)
                            .font(MyFont.getFont(.NORMAL, 18))
                            .multilineTextAlignment(.center)
                            .lineSpacing(8)
                            .frame(width: UIScreen.main.bounds.width, alignment: .center)

                        Spacer()

                    }
                    
                    StandardButton(style: .white, title: "save", loadingProcess: $process) {
                        validatePhoto()
                    }
                    .padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight + 24, trailing: 0))
                }
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .topLeading)
            .background(ColorList.main.color.edgesIgnoringSafeArea(.all))
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.main.color, style: .lightContent))
            }
    }

    private func validatePhoto() {
        process.toggle()
        mediator.cropImage()
        mediator.searchFaces { success in
            if success {
                saveImage()
            } else {
                process.toggle()
                store.dispatch(action: .showBottomSheet(view: .NOT_CORRECT_PHOTO))
                mediator.croppedPhoto = UIImage()
            }
        }
    }

    private func saveImage() {
        ImageUtils.resize(image: mediator.croppedPhoto) { image in
            mediator.saveImage(image: mediator.croppedPhoto) { success in
                DispatchQueue.main.async {
                    process.toggle()
                    if success {
                        store.dispatch(action: .navigationBack)
                        store.dispatch(action: .showBottomSheet(view: .PHOTO_SETTINGS))
                    }
                }
            }
        }
    }
}

struct PhotoEditingScreen_Previews: PreviewProvider {
    static var previews: some View {
        PhotoEditingScreen()
    }
}
