//
//  PhotoSettingsBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 15.06.2022.
//

import SwiftUI

struct PhotoSettingsBottomSheet: View {
    @EnvironmentObject var store: Store
    @ObservedObject var editorHolder = PhotoEditorDataHolder.shared
    @ObservedObject var registrationHolder = RegistrationDataHolder.shared
    
    @State var process: Bool = false
    var clickAction: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack(spacing: 0) {
                Image(uiImage: editorHolder.croppedPhoto)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 91, height: 91)
                    .cornerRadius(16)
                    .padding(.init(top: 0, leading: 32, bottom: 0, trailing: 16))
                
                CircleImageButton(imageName: "ic_trash", strokeColor: MyColor.getColor(255, 255, 255, 0.03), shadowColor: MyColor.getColor(0, 0, 0, 0.16), circleSize: .SMALL) {
                    registrationHolder.deleteImage(image: editorHolder.croppedPhoto)
                }
                    .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .zIndex(10)
                
                CircleImageButton(imageName: "ic_edit", strokeColor: MyColor.getColor(255, 255, 255, 0.03), shadowColor: MyColor.getColor(0, 0, 0, 0.16), circleSize: .SMALL) {  }
                    .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .zIndex(10)
                
                Spacer()
            }.padding(.init(top: 0, leading: 0, bottom: 10, trailing: 0))
            
            SwichSelectorView(isActive: false, hint: "set_as_a_profile_photo", text: "main_picture", clickInfoAction: infoClickAction()) { isChecked in }
            
            SwichSelectorView(isActive: false, hint: "take_part_in_a_contest", text: "mutual_sympathy", clickInfoAction: infoClickAction()) { isChecked in }
            
            SwichSelectorView(isActive: false, hint: "take_part_in_a_contest", text: "top_50", clickInfoAction: infoClickAction()) { isChecked in  }
            
            StandardButton(style: .white, title: "save_changes", loadingProcess: $process) {
                clickAction()
                registrationHolder.saveImage(image: editorHolder.croppedPhoto)
                store.dispatch(action:
                        .setScreenColors(status: ColorList.transparent.color, style: .lightContent))
            }.padding(.init(top: 36, leading: 0, bottom: 22, trailing: 0))
        }
    }
    
    private func infoClickAction() -> () -> Void {
        {
            store.dispatch(action: .show(message: "info is clicked"))
        }
    }
}

struct PhotoSettingsBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSettingsBottomSheet { }
    }
}
