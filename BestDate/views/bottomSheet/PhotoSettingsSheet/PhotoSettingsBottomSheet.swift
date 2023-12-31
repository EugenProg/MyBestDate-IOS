//
//  PhotoSettingsBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 15.06.2022.
//

import SwiftUI

struct PhotoSettingsBottomSheet: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = PhotoSettingsSheetMediator.shared
    @State var ready: Bool = false
    
    @State var saveProcess: Bool = false
    @State var deleteProcess: Bool = false

    @State var saveAction: Bool = false
    var clickAction: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                AsyncImageView(url: mediator.selectedPhoto?.thumb_url)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 91, height: 91)
                    .cornerRadius(16)
                    .padding(.init(top: 0, leading: 32, bottom: 0, trailing: 16))
                    .opacity(ready ? 1 : 0)
                
                CircleImageButton(imageName: "ic_trash", strokeColor: MyColor.getColor(255, 255, 255, 0.03), shadowColor: MyColor.getColor(0, 0, 0, 0.16), circleSize: .SMALL, loadingProcess: $deleteProcess) {
                    deleteProcess.toggle()
                    mediator.deleteImage(id: mediator.selectedPhoto?.id ?? 0) { success in
                        DispatchQueue.main.async {
                            deleteProcess.toggle()
                            clickAction()
                        }

                    }
                }
                    .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .zIndex(10)
                
                Spacer()
            }.padding(.init(top: 0, leading: 0, bottom: 10, trailing: 0))

            if mediator.showMainBlock {
                SwichSelectorView(isActive: $mediator.isMain, hint: "set_as_a_profile_photo", text: "main_picture", clickInfoAction: infoClickAction()) { isChecked in
                    mediator.selectedPhoto?.main = isChecked
                }
            }
            
            SwichSelectorView(isActive: $mediator.topEnabled, hint: "take_part_in_a_contest", text: "top_50", clickInfoAction: infoClickAction()) { isChecked in
                mediator.selectedPhoto?.top = isChecked
             }
            
            StandardButton(style: .white, title: "save_changes", loadingProcess: $saveProcess) {
                self.saveAction = true
                save()
            }.padding(.init(top: 36, leading: 0, bottom: 22, trailing: 0))
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                withAnimation { ready.toggle() }
            })
        }
        .onDisappear {
            if !self.saveAction { mediator.updateDataAction { } }
        }
    }
    
    private func infoClickAction() -> () -> Void {
        {
            //store.dispatch(action: .show(message: "info is clicked"))
        }
    }

    private func save() {
        saveProcess.toggle()
        store.dispatch(action: .startProcess)
        mediator.updateImageStatus(image: mediator.selectedPhoto) { success in
            DispatchQueue.main.async {
                saveProcess.toggle()
                store.dispatch(action: .endProcess)
                clickAction()
            }
        }
    }
}
