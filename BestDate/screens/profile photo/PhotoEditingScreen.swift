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
    @State var cropAction: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                EdiorView(backgroundColor: ColorList.main.color, onCrop: { croppedImage, success in
                    if success {
                        validatePhoto(croppedImage: croppedImage)
                    }
                }, cropAction: $cropAction)
                
                VStack(alignment: .leading, spacing: 0) {
                        BackButton(style: .white) {
                            ImagePickerMediator.shared.isShowingPhotoLibrary.toggle()
                            store.dispatch(action: .navigationBack)
                        }.padding(.init(top: 32, leading: 32, bottom: 15, trailing: 32))
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 30)
                        .fill(ColorList.transparent.color)
                        .frame(width: UIScreen.main.bounds.width - 14, height: UIScreen.main.bounds.width - 14)
                    
                    Spacer()
                    
                    StandardButton(style: .white, title: "save", loadingProcess: $process) {
                        cropAction.toggle()
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

    private func validatePhoto(croppedImage: UIImage?) {
        process.toggle()
        mediator.croppedPhoto = croppedImage ?? UIImage()
        mediator.searchFaces { success in
            saveImage(moderated: !success)
        }
    }

    private func saveImage(moderated: Bool) {
        ImageUtils.resize(image: mediator.croppedPhoto) { image in
            mediator.saveImage(image: image, moderated: moderated) { success in
                DispatchQueue.main.async {
                    process.toggle()
                    if success {
                        ProfileMediator.shared.updateUserData { }
                        store.dispatch(action: .navigationBack)
                        if !moderated {
                            store.dispatch(action: .showBottomSheet(view: .PHOTO_SETTINGS))
                        }
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
